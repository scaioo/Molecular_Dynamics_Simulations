                      :-) GROMACS - gmx grompp, 2023.4 (-:

Executable:   /usr/local/gromacs/bin/gmx
Data prefix:  /usr/local/gromacs
Working dir:  /home/scaio/MOL_DYN_SIM/Exercise-06
Command line:
  gmx grompp -f /home/scaio/MOL_DYN_SIM/Exercise-06/MDP/em_9.mdp -c ./methane_water.gro -p /home/scaio/MOL_DYN_SIM/Exercise-06/topol.top -o /home/scaio/MOL_DYN_SIM/Exercise-06/lambda_9/em/em.tpr -po /home/scaio/MOL_DYN_SIM/Exercise-06/lambda_9/em/mdout.mdp

Ignoring obsolete mdp entry 'ns_type'

NOTE 1 [file /home/scaio/MOL_DYN_SIM/Exercise-06/MDP/em_9.mdp, line 75]:
  For proper sampling of the (nearly) decoupled state, stochastic dynamics
  should be used


NOTE 2 [file /home/scaio/MOL_DYN_SIM/Exercise-06/MDP/em_9.mdp]:
  With Verlet lists the optimal nstlist is >= 10, with GPUs >= 20. Note
  that with the Verlet scheme, nstlist has no effect on the accuracy of
  your simulation.

Generating 1-4 interactions: fudge = 0.5
Number of degrees of freedom in T-Coupling group rest is 3584.00
The integrator does not provide a ensemble temperature, there is no system ensemble temperature

There were 2 NOTEs

Back Off! I just backed up /home/scaio/MOL_DYN_SIM/Exercise-06/lambda_9/em/em.tpr to /home/scaio/MOL_DYN_SIM/Exercise-06/lambda_9/em/#em.tpr.1#

GROMACS reminds you: "Chance favors the prepared mind." (Louis Pasteur)

Setting the LD random seed to -143807569

Generated 331705 of the 331705 non-bonded parameter combinations

Generated 331705 of the 331705 1-4 parameter combinations

Excluding 3 bonded neighbours molecule type 'Methane'

turning H bonds into constraints...

Excluding 2 bonded neighbours molecule type 'SOL'

turning H bonds into constraints...

Coupling 1 copies of molecule type 'Methane'
Analysing residue names:
There are:     1      Other residues
There are:   596      Water residues
Analysing residues not classified as Protein/DNA/RNA/Water and splitting into groups...

The largest distance between non-perturbed excluded atoms is 0.164 nm between atom 1174 and 1175
Calculating fourier grid dimensions for X Y Z
Using a fourier grid of 25x25x25, spacing 0.119 0.119 0.119

Estimate for the relative computational load of the PME mesh part: 0.33

This run will generate roughly 20 Mb of data
