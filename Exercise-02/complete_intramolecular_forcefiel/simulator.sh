#!/bin/bash

# Exit on error
set -e
# --- Input arguments ---

# --- Usage check ---

# Summary of the simulation before running:
echo "Running simulation"

#echo "- Timestep: ${STEP_NUM} ps"


# Step 1: Energy minimization


# Step 2: Simulation
gmx grompp -f polymer.mdp -c polymer.gro -p polymer.top -o polymer_fj.tpr
gmx mdrun -deffnm polymer_fj -v

# Step 3: Parameters extraction (rmsd gyr rad):
gmx polystat -s polymer_fj.tpr -f polymer_fj.xtc -o fj_polystat.xvg

# Step 3: Parameters extraction (angles):
gmx mk_angndx -s polymer_fj.tpr -n angle.ndx -type angle
gmx angle -f polymer_fj.xtc -n angle.ndx -od fj_angle_hist.xvg -type angle -ov fj_angle.xvg

# Step 4: Visualize the Resuls:

