#!/bin/bash

# Loop through each frame listed in important_frames.txt
for frame in $(cat important_frames.txt); do
	fname=${frame%%.*}  # Remove decimal part if present (e.g. 12.000 → 12)

	echo ">>> Processing frame $fname"

	# Step 1: Energy minimization / NPT equilibration for this frame
	gmx grompp -f npt_umbrella.mdp -c conf${fname}.gro -p topol.top -r conf${fname}.gro -n index.ndx -o npt${fname}.tpr -maxwarn 3
	gmx mdrun -v -deffnm npt${fname}
	
	# Step 2: Umbrella sampling production MD
	gmx grompp -f md_umbrella.mdp -c npt${fname}.gro -t npt${fname}.cpt -p topol.top -r npt${fname}.gro -n index.ndx -o umbrella${fname}.tpr -maxwarn 3
	gmx mdrun -v -deffnm umbrella${fname}
done

