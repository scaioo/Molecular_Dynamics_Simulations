#TITLE: Automated script to create a solvated simulation box for a 10mer A-DNA using GROMACS
#!/bin/bash

#create .gro file
printf "6\n" | gmx pdb2gmx -f 10mer_a-DNA.pdb -water spce -ignh -o a-DNA.gro
#create box
gmx solvate -cs spc216 -cp a-DNA.gro -p topol.top -box 5 5 5 -o a-DNA.gro
#create .tpr file
gmx grompp -f em.mdp -p topol.top -c a-DNA.gro -o a-DNA.tpr -maxwarn 1
# generate ion 
printf "3\n" | gmx genion -s a-DNA.tpr -o neutralized_a-DNA.gro -p topol.top -pname NA -nname CL -neutral
# Minimize energy
gmx grompp -f em.mdp -p topol.top -c neutralized_a-DNA.gro -o em_a-DNA.tpr
gmx mdrun -v -deffnm em_a-DNA

# NVT NPT Equilibration of the system
gmx grompp -f nvt.mdp -p topol.top -c em_a-DNA.gro -o nvt_a-DNA.tpr -maxwarn 1
gmx mdrun -v -deffnm nvt_a-DNA
gmx grompp -f npt.mdp -p topol.top -c nvt_a-DNA.gro -o npt_a-DNA.tpr -maxwarn 2
gmx mdrun -v -deffnm npt_a-DNA

# Preproduction and production run with PME
gmx grompp -f pme_pre.mdp -p topol.top -c npt_a-DNA.gro -o pme_pre_a-DNA.tpr
gmx mdrun -v -deffnm pme_pre_a-DNA
gmx grompp -f pme_prod.mdp -p topol.top -c pme_pre_a-DNA.gro -o pme_prod_a-DNA.tpr
gmx mdrun -v -deffnm pme_prod_a-DNA

# Preproduction and production run with sh8
gmx grompp -f sh8_pre.mdp -p topol.top -c npt_a-DNA.gro -o sh8_pre_a-DNA.tpr
gmx mdrun -v -deffnm sh8_pre_a-DNA
gmx grompp -f sh8_prod.mdp -p topol.top -c sh8_pre_a-DNA.gro -o sh8_prod_a-DNA.tpr
gmx mdrun -v deffnm sh8_prod_a-DNA
#! with dt= 0.002 and nsteps = 2500000 segmentation fault so rerun with dt=0.001 and nsteps = 5000000
gmx grompp -f sh8_prod.mdp -p topol.top -c sh8_pre_a-DNA.gro -o sh8_prod_a-DNA_dt1.tpr
gmx mdrun -v -deffnm sh8_prod_a-DNA_dt1

# Preproduction and production run with sh12
gmx grompp -f sh12_pre.mdp -p topol.top -c npt_a-DNA.gro -o sh12_pre_a-DNA.tpr
gmx mdrun -v -deffnm sh12_pre_a-DNA
gmx grompp -f sh12_prod.mdp -p topol.top -c sh12_pre_a-DNA.gro -o sh12_prod_a-DNA.tpr
gmx mdrun -v -deffnm sh12_prod_a-DNA
#

# Preproduction and production run with tr8
gmx grompp -f tr8_pre.mdp -p topol.top -c npt_a-DNA.gro -o tr8_pre_a-DNA.tpr
gmx mdrun -v -deffnm tr8_pre_a-DNA
gmx grompp -f tr8_prod.mdp -p topol.top -c tr8_pre_a-DNA.gro -o tr8_prod_a-DNA.tpr
gmx mdrun -v -deffnm tr8_prod_a-DNA
#

# Preproduction and production run with tr12
gmx grompp -f tr12_pre.mdp -p topol.top -c npt_a-DNA.gro -o tr12_pre_a-DNA.tpr
gmx mdrun -v -deffnm tr12_pre_a-DNA
gmx grompp -f tr12_prod.mdp -p topol.top -c tr12_pre_a-DNA.gro -o tr12_prod_a-DNA.tpr
gmx mdrun -v -deffnm tr12_prod_a-DNA
#

# Preproduction and production run with tr18
gmx grompp -f tr18_pre.mdp -p topol.top -c npt_a-DNA.gro -o tr18_pre_a-DNA.tpr
gmx mdrun -v -deffnm tr18_pre_a-DNA
gmx grompp -f tr18_prod.mdp -p topol.top -c tr18_pre_a-DNA.gro -o tr18_prod_a-DNA.tpr
gmx mdrun -v deffnm tr18_prod_a-DNA
#

# rdf Analysis for PME
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f pme_prod_a-DNA.gro -o pme_prod_index.ndx
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f pme_pre_a-DNA.gro -o pme_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f pme_pre_a-DNA.gro -s pme_pre_a-DNA.tpr -center -n pme_pre_index.ndx -pbc mol -o pme_pre_a-DNA_trj.gro 
printf "10\n 0\n" |gmx trjconv -f pme_prod_a-DNA.xtc -s pme_prod_a-DNA.tpr -n pme_prod_index.ndx -pbc mol -center -o pme_prod_a-DNA_trj_centered.xtc
gmx rdf -f pme_prod_a-DNA_trj_centered.xtc -s pme_pre_a-DNA_trj.gro -n pme_prod_index.ndx -o rdf_pme.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f pme_prod_a-DNA_trj_centered.xtc -s pme_pre_a-DNA_trj.gro -o rmsd_pme.xvg -n pme_pre_index.ndx -tu ps
# rdf Analysis for SH8
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f sh8_prod_a-DNA.gro -o sh8_prod_index.ndx
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f sh8_pre_a-DNA.gro -o sh8_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f sh8_pre_a-DNA.gro -s sh8_pre_a-DNA.tpr -center -n sh8_pre_index.ndx -pbc mol -o sh8_pre_a-DNA_trj.gro
printf "10\n 0\n" | gmx trjconv -f sh8_prod_a-DNA.xtc -s sh8_prod_a-DNA.tpr -n sh8_prod_index.ndx -pbc mol -center -o sh8_prod_a-DNA_trj_centered.xtc
gmx rdf -f sh8_prod_a-DNA_trj_centered.xtc -s sh8_pre_a-DNA_trj.gro -n sh8_prod_index.ndx -o rdf_sh8.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f sh8_prod_a-DNA_trj_centered.xtc -s sh8_pre_a-DNA_trj.gro -o rmsd_sh8.xvg -n sh8_pre_index.ndx -tu ps
#
# rdf Analysis for SH12
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f sh12_prod_a-DNA.gro -o sh12_prod_index.ndx  
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f sh12_pre_a-DNA.gro -o sh12_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f sh12_pre_a-DNA.gro -s sh12_pre_a-DNA.tpr -center -n sh12_pre_index.ndx -pbc mol -o sh12_pre_a-DNA_trj.gro
printf "10\n 0\n" | gmx trjconv -f sh12_prod_a-DNA.xtc -s sh12_prod_a-DNA.tpr -n sh12_prod_index.ndx -pbc mol -center -o sh12_prod_a-DNA_trj_centered.xtc
gmx rdf -f sh12_prod_a-DNA_trj_centered.xtc -s sh12_pre_a-DNA_trj.gro -n sh12_prod_index.ndx -o rdf_sh12.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f sh12_prod_a-DNA_trj_centered.xtc -s sh12_pre_a-DNA_trj.gro -o rmsd_sh12.xvg -n sh12_pre_index.ndx -tu ps
# rdf Analysis for TR8
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr8_prod_a-DNA.gro -o tr8_prod_index.ndx
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr8_pre_a-DNA.gro -o tr8_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f tr8_pre_a-DNA.gro -s tr8_pre_a-DNA.tpr -center -n tr8_pre_index.ndx -pbc mol -o tr8_pre_a-DNA_trj.gro
printf "10\n 0\n" | gmx trjconv -f tr8_prod_a-DNA.xtc -s tr8_prod_a-DNA.tpr -n tr8_prod_index.ndx -pbc mol -center -o tr8_prod_a-DNA_trj_centered.xtc
gmx rdf -f tr8_prod_a-DNA_trj_centered.xtc -s tr8_pre_a-DNA_trj.gro -n tr8_prod_index.ndx -o rdf_tr8.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f tr8_prod_a-DNA_trj_centered.xtc -s tr8_pre_a-DNA_trj.gro -o rmsd_tr8.xvg -n tr8_pre_index.ndx -tu ps
# rdf Analysis for TR12
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr12_prod_a-DNA.gro -o tr12_prod_index.ndx
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr12_pre_a-DNA.gro -o tr12_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f tr12_pre_a-DNA.gro -s tr12_pre_a-DNA.tpr -center -n tr12_pre_index.ndx -pbc mol -o tr12_pre_a-DNA_trj.gro
printf "10\n 0\n" | gmx trjconv -f tr12_prod_a-DNA.xtc -s tr12_prod_a-DNA.tpr -n tr12_prod_index.ndx -pbc mol -center -o tr12_prod_a-DNA_trj_centered.xtc
gmx rdf -f tr12_prod_a-DNA_trj_centered.xtc -s tr12_pre_a-DNA_trj.gro -n tr12_prod_index.ndx -o rdf_tr12.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f tr12_prod_a-DNA_trj_centered.xtc -s tr12_pre_a-DNA_trj.gro -o rmsd_tr12.xvg -n tr12_pre_index.ndx -tu ps
# rdf Analysis for TR18
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr18_prod_a-DNA.gro -o tr18_prod_index.ndx
printf " a O1P | a O2P\na OW\na 1-315\nq\n" | gmx make_ndx -f tr18_pre_a-DNA.gro -o tr18_pre_index.ndx
printf "10\n 0\n" | gmx trjconv -f tr18_pre_a-DNA.gro -s tr18_pre_a-DNA.tpr -center -n tr18_pre_index.ndx -pbc mol -o tr18_pre_a-DNA_trj.gro
printf "10\n 0\n" | gmx trjconv -f tr18_prod_a-DNA.xtc -s tr18_prod_a-DNA.tpr -n tr18_prod_index.ndx -pbc mol -center -o tr18_prod_a-DNA_trj_centered.xtc
gmx rdf -f tr18_prod_a-DNA_trj_centered.xtc -s tr18_pre_a-DNA_trj.gro -n tr18_prod_index.ndx -o rdf_tr18.xvg -ref 8 -sel 9
printf "1\n 1\n" | gmx rms -f tr18_prod_a-DNA_trj_centered.xtc -s tr18_pre_a-DNA_trj.gro -o rmsd_tr18.xvg -n tr18_pre_index.ndx -tu ps