# Create topology 
gmx pdb2gmx -f 5YOK.pdb -o processed.gro -water tip3p -ignh -ff amber99sb-ildn
# Create box
gmx editconf -f processed.gro -o newbox.gro -c -d 1.0 -bt dodecahedron
# Solvate the system
gmx solvate -cp newbox.gro -cs spc216.gro -o solvated.gro -p topol.top
# Preprocess for ion generation
gmx grompp -f ions.mdp -c solvated.gro -p topol.top -o ions.tpr -maxwarn 1
# Replace solvent molecules with ions (select group SOL)
gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -pname NA -nname CL -neutral -conc 0.15 
# Energy minimization
gmx grompp -f minim.mdp -c solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
# NVT equilibration
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt
# NPT equilibration
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
# preproduction run
gmx grompp -f preprod.mdp -c npt.gro -r npt.gro -p topol.top -o md_pre.tpr
gmx mdrun -v -deffnm md_pre
# Production run
gmx grompp -f prod.mdp -c md_pre.gro -r md_pre.gro -p topol.top -o md.tpr
gmx mdrun -v -deffnm md
# Center the molecule (protein/system)
gmx trjconv -s md.tpr -f md.xtc -o prod_center.xtc -center -pbc mol
# calculate radius of gyration (protein)
gmx gyrate -f prod_center.xtc -s md.tpr -o rgyr.xvg
# calculate RMSD (protein)
gmx rms -s md.tpr -f prod_center.xtc -o rmsd.xvg -tu ns
# PCA analysis
gmx covar -f prod_center.xtc -s md.tpr -o eigenval.xvg -v eigenvec.trr -xpma covar_matrix.xpm
gmx_mpi anaeig -v eigenvec.trr -f prod_center.xtc -s md.tpr -proj eigproj1_10.xvg -comp eigcomp1_10.xvg -last 10
