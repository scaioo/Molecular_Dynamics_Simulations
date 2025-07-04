# For the gro and top file creation:
gmx solvate -cs spc216 -box 2.504 2.504 2.504 -maxsol 1 -o tip3p.gro
gmx insert -molecules -ci tip3p.gro -box 2.504 2.504 2.504 -nmol 523-try 10000 -o choice_tauP.gro
n_standard                            	
gmx pdb2gmx -f choice_tauP.gro -p choice_tauP.top -water tip3p -o trash.gro # UI prompted after execution

# For the minimization of the water box:
gmx grompp -f em.mdp -c choice_tauP.gro -p choice_tauP.top -o em_tip3p.tpr
gmx mdrun -v -deffnm em_tip3p

# NVT Simulation 
gmx grompp -f nvt.mdp -c em_tip3p.gro -p choice_tauP.top -o eq_tip3p.tpr -maxwarn 1
gmx mdrun -v -deffnm eq_tip3p

# NPT-Ensemble 

## For Berendsen (note on the mdp files there is the berendsen barostat)
### For Tp = 0.05
gmx grompp -f npt_0.05.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_0.05.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_0.05
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f prod_berendsen_0.05.edr -s prod_berendsen_0.05.tpr -o berendsen_0.05.xvg -fluct_props -nmol 523
# NOTE !! The first frames are not equilibrated -->
gmx energy -b 200 -f prod_berendsen_0.05.edr -s prod_berendsen_0.05.tpr -o berendsen_0.05.xvg -fluct_props -nmol 523

### For Tp = 0.1
gmx grompp -f npt_0.1.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_0.1.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_0.1
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_berendsen_0.1.edr -s prod_berendsen_0.1.tpr -o berendsen_0.1.xvg -fluct_props -nmol 523

### For Tp = 0.5
gmx grompp -f npt_0.5.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_0.5.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_0.5
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_berendsen_0.5.edr -s prod_berendsen_0.5.tpr -o berendsen_0.5.xvg -fluct_props -nmol 523

### For Tp = 1.0
gmx grompp -f npt_1.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_1.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_1
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_berendsen_1.edr -s prod_berendsen_1.tpr -o berendsen_1.xvg -fluct_props -nmol 523

### For Tp = 5.0
gmx grompp -f npt_5.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_5.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_5
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_berendsen_5.edr -s prod_berendsen_5.tpr -o berendsen_5.xvg -fluct_props -nmol 523

### For Tp = 10.0
gmx grompp -f npt_10.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_berendsen_10.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_berendsen_10
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_berendsen_10.edr -s prod_berendsen_10.tpr -o berendsen_10.xvg -fluct_props -nmol 523

## For Parrinello-Rahman (note: on the .mdp files these is now Parrinello-Rahman)
### For Tp = 0.05
gmx grompp -f npt_0.05.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_0.05.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_0.05
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f prod_PR_0.05.edr -s prod_PR_0.05.tpr -o PR_0.05.xvg -fluct_props -nmol 523
# NOTE !! The first frames are not equilibrated -->
gmx energy -b 200 -f prod_PR_0.05.edr -s prod_PR_0.05.tpr -o PR_0.05.xvg -fluct_props -nmol 523

### For Tp = 0.1
gmx grompp -f npt_0.1.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_0.1.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_0.1
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_PR_0.1.edr -s prod_PR_0.1.tpr -o PR_0.1.xvg -fluct_props -nmol 523

### For Tp = 0.5
gmx grompp -f npt_0.5.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_0.5.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_0.5
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_PR_0.5.edr -s prod_PR_0.5.tpr -o PR_0.5.xvg -fluct_props -nmol 523

### For Tp = 1.0
gmx grompp -f npt_1.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_1.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_1
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_PR_1.edr -s prod_PR_1.tpr -o PR_1.xvg -fluct_props -nmol 523

### For Tp = 5.0
gmx grompp -f npt_5.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_5.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_5
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_PR_5.edr -s prod_PR_5.tpr -o PR_5.xvg -fluct_props -nmol 523

### For Tp = 10.0
gmx grompp -f npt_10.mdp -c eq_tip3p.gro -p choice_tauP.top -o prod_PR_10.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_PR_10
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_PR_10.edr -s prod_PR_10.tpr -o PR_10.xvg -fluct_props -nmol 523


## Other Water models

### spce
gmx solvate -cs spc216 -box 2.504 2.504 2.504 -maxsol 1 -o spce.gro
gmx insert-molecules -ci spce.gro -box 2.504 2.504 2.504 -nmol 523-try 10000 -o choice_tauT_spce.gro
gmx pdb2gmx -f choice_tauP_spce.gro -p choice_tauP_spce.top -water spce -o trash.gro # UI prompted after execution

# For the minimization of the water box:
gmx grompp -f em.mdp -c choice_tauP_spce.gro -p choice_tauP_spce.top -o em_spce.tpr
gmx mdrun -v -deffnm em_spce

# NVT Equilibration
gmx grompp -f nvt.mdp -c em_spce.gro -p choice_tauP_spce.top -o n_eq_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm n_eq_spce

#NPT Equilibration (berensen)
gmx grompp -f npt_0.05.mdp -c n_eq_spce.gro -p choice_tauP_spce.top -o eq_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm eq_spce

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f npt_0.05.mdp -c eq_spce.gro -p choice_tauP_spce.top -o preprod_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm preprod_spce

### production run (Parrinnello-Rahman)
gmx grompp -f npt_0.05.mdp -c preprod_spce.gro -p choice_tauP_spce.top -o prod_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_spce

# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_spce.edr -s prod_spce.tpr -o spce.xvg -fluct_props -nmol 523 

### TIP4P
gmx solvate -cs tip4p.gro -box 2.504 2.504 2.504 -maxsol 1 -o tip4p.gro
gmx insert-molecules -ci tip4p.gro -box 2.504 2.504 2.504 -nmol 523 -try 10000 -o choice_tauT_spce.gro
gmx pdb2gmx -f choice_tauP_tip4p.gro -p choice_tauP_tip4p.top -water tip4p -o trash.gro # UI prompted after execution

# For the minimization of the water box:
gmx grompp -f em.mdp -c choice_tauP_tip4p.gro -p choice_tauP_tip4p.top -o em_tip4p.tpr
gmx mdrun -v -deffnm em_tip4p

# NVT Equilibration
gmx grompp -f nvt.mdp -c em_tip4p.gro -p choice_tauP_tip4p.top -o n_eq_tip4p.tpr -maxwarn 1
gmx mdrun -v -deffnm n_eq_tip4p

#NPT Equilibration (berensen)
gmx grompp -f waters_npt.mdp -c n_eq_tip4p.gro -p choice_tauP_tip4p.top -o waters_eq_tip4p.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_eq_tip4p

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f waters_pre.mdp -c waters_eq_tip4p.gro -p choice_tauP_tip4p.top -o waters_preprod_tip4p.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_preprod_tip4p

### production run (Parrinnello-Rahman)
gmx grompp -f waters_prod.mdp -c waters_preprod_tip4p.gro -p choice_tauP_tip4p.top -o waters_prod_tip4p.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_prod_tip4p

### --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f waters_prod_tip4p.edr -s waters_prod_tip4p.tpr -o waters_tip4p.xvg -fluct_props -nmol 523


# Let's try with T_P=0.1 for  atm

## SPCE

#NPT Equilibration (berensen)
gmx grompp -f waters_npt.mdp -c n_eq_spce.gro -p choice_tauP_spce.top -o waters_eq_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_eq_spce

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f waters_pre.mdp -c waters_eq_spce.gro -p choice_tauP_spce.top -o waters_preprod_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_preprod_spce

### production run (Parrinnello-Rahman)
gmx grompp -f waters_prod.mdp -c waters_preprod_spce.gro -p choice_tauP_spce.top -o waters_prod_spce.tpr -maxwarn 1
gmx mdrun -v -deffnm waters_prod_spce

# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f waters_prod_spce.edr -s waters_prod_spce.tpr -o waters_spce.xvg -fluct_props -nmol 523

#TIP4P

#NPT Equilibration (berensen)
gmx grompp -f npt_1.mdp -c n_eq_tip4p.gro -p choice_tauP_tip4p.top -o eq_tip4p_1.tpr -maxwarn 1
gmx mdrun -v -deffnm eq_tip4p_1

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f npt_1.mdp -c eq_tip4p.gro -p choice_tauP_tip4p.top -o preprod_tip4p_1.tpr -maxwarn 1
gmx mdrun -v -deffnm preprod_tip4p_1

### production run (Parrinnello-Rahman)
gmx grompp -f npt_1.mdp -c preprod_tip4p_1.gro -p choice_tauP_tip4p.top -o prod_tip4p_1.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_tip4p_1

### --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -b 200 -f prod_tip4p_1.edr -s prod_tip4p_1.tpr -o tip4p_1.xvg -fluct_props -nmol 523

## STANDARD NON STANDARD

## STANDARD
#NPT Equilibration (berensen)
gmx grompp -f standard.mdp -c n_eq_spce.gro -p choice_tauP_spce.top -o eq_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm eq_standard

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f standard.mdp -c eq_standard.gro -p choice_tauP_spce.top -o preprod_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm preprod_standard

### production run (Parrinnello-Rahman)
gmx grompp -f standard.mdp -c preprod_standard.gro -p choice_tauP_spce.top -o prod_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_standard

# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f prod_standard.edr -s prod_standard.tpr -o standard.xvg -fluct_props -nmol 523

## NON STANDARD
#NPT Equilibration (berensen)
gmx grompp -f non_standard.mdp -c n_eq_spce.gro -p choice_tauP_spce.top -o eq_non_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm eq_non_standard

### Preproduction run (Nose-Hoover and Parrinello Rahman)
gmx grompp -f non_standard.mdp -c eq_non_standard.gro -p choice_tauP_spce.top -o preprod_non_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm preprod_non_standard

### production run (Parrinnello-Rahman)
gmx grompp -f non_standard.mdp -c preprod_non_standard.gro -p choice_tauP_spce.top -o prod_non_standard.tpr -maxwarn 1
gmx mdrun -v -deffnm prod_non_standard
# --> Energy and measures: pot. kin. tot. Energy, Temperature, Volume
gmx energy -f prod_non_standard.edr -s prod_non_standard.tpr -o non_standard.xv ufluct_props -nmol 523
