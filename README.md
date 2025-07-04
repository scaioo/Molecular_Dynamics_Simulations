# Molecular Dynamics Simulations with GROMACS

This repository contains a series of exercises to learn and apply key molecular dynamics (MD) simulation techniques using **GROMACS**, one of the most popular MD simulation packages.

The exercises progressively cover fundamental and advanced topics in MD, including temperature and pressure coupling, system equilibration, free energy calculations, and advanced analysis methods.

---

## 🧪 Contents

The repository is organized as follows:

- `Exercise_1/` to `Exercise_8/`:  
  Individual exercises containing input files, simulation setups, and analysis scripts.
- `Exercise/`:  
  Starter files and templates for the exercises.
- `Solution/`:  
  Example solutions and reference outputs for each exercise.

---

## 📂 Topics Covered

The exercises cover the following topics:

- **Exercise 1:** Temperature coupling (**Tcoupling**) and system equilibration
- **Exercise 2:** Pressure coupling (**Pcoupling**) and barostat setup
- **Exercise 3:** Preparation of a simulation box, topology, and energy minimization
- **Exercise 4:** Comparison of **Water Models** (e.g., SPC, TIP3P)
- **Exercise 5:** **Umbrella Sampling** for potential of mean force calculations
- **Exercise 6:** **Principal Component Analysis (PCA)** of MD trajectories
- **Exercise 7:** **Solvation Free Energy** calculations using the **BAR method**
- **Exercise 8:** Analysis of **Protein-Protein Interaction Stabilizers**

---

## ⚙️ Requirements

To run the simulations and analyses, the following software is required:

### Software
- [GROMACS](https://manual.gromacs.org/documentation/current/install-guide/index.html) (version 2020 or later recommended)
- Python 3.x with the following libraries:
  - [`pandas`](https://pandas.pydata.org/)
  - [`numpy`](https://numpy.org/)
  - [`matplotlib`](https://matplotlib.org/)

You can install the Python dependencies with:

```bash
pip install pandas numpy matplotlib
```
### 🚀 Getting Started
1. Clone the repository:
```bash
git clone https://github.com/scaioo/Molecular_Dynamics_Simulations.git
cd Molecular_Dynamics_Simulations
```
2. Navigate to the desired exercise directory:
```bash
cd Exercise_1
```

### ✍️ Author
Andrea Scaioli