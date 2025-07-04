#!/bin/bash

# Exit on error
set -e
# --- Input arguments ---
TOPO_NUM="$1"      # e.g., 2 → topol_2.top
STEP_NUM="$2"      # e.g., 1 → intro_0.001.mdp

# --- Usage check ---
if [[ -z "$TOPO_NUM" || -z "$STEP_NUM" ]]; then
	  echo "Usage: $0 <TOPO_NUM> <STEP_NUM>"
	    echo "Example: $0 2 0.001"
	      exit 1
fi

# Summary of the simulation before running:
echo "Running simulation with:"
echo "- Topology: topol_${TOPO_NUM}.top"
echo "- Timestep: ${STEP_NUM} ps"

# Create intro_STEP_NUM file: 
cp intro.mdp intro_${STEP_NUM}.mdp
sed -i "s/^\([[:space:]]*dt[[:space:]]*=[[:space:]]*\)[^[:space:]]*/\1${STEP_NUM}/" intro_${STEP_NUM}.mdp


# Step 1: Energy minimization
gmx grompp -f em.mdp -p topol_${TOPO_NUM}.top -c intro.gro -o em_${TOPO_NUM}.tpr
gmx mdrun -v -deffnm em_${TOPO_NUM}

# Step 2: NVT/short simulation
gmx grompp -f intro_${STEP_NUM}.mdp -p topol_${TOPO_NUM}.top -c em_${TOPO_NUM}.gro -o intro_${STEP_NUM}_${TOPO_NUM}.tpr -maxwarn 3
gmx mdrun -v -deffnm intro_${STEP_NUM}_${TOPO_NUM}

# Step 3: Energy extraction (example: kinetic, potential, total)
printf "4\n5\n6\n" | gmx energy -f intro_${STEP_NUM}_${TOPO_NUM}.edr -o intro_${STEP_NUM}_${TOPO_NUM}.xvg

# Step 4: Visualize the Resuls:
xmgrace -nxy intro_${STEP_NUM}_${TOPO_NUM}.xvg
