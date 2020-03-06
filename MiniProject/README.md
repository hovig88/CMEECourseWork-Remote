# MiniProject (Week 8): Miniproject: Hackathon

* The eight week focused on the miniproject assignment in a hackathon format.

* The **MiniProject** directory includes the following subdirectories: *code*, *data*, *readings*, *results*, and *sandbox*.
    - code - includes scripts needed for the miniproject
    - data - includes data needed for some of the scripts/commands
    - readings - required background readings for the miniproject
    - results - essentially an empty directory, but includes a .gitignore file (since completely empty directories cannnot be pushed to git)
    - sandbox - similar to a recycle bin; disposing files that are not needed for assessment, but might still be useful for the author if and when needed

## Contents

### Code

* CompileLaTeX.sh - bash script that compiles a LaTeX file and converts it to pdf
* Data_Preparation.R - R script that performs data wranling on the raw data and prepares it for model fitting
* Final_plotting_and_analysis.R - R script that does plotting of fitted models with data as well as some analyses work
* MiniProject_Report.tex - miniproject report written in LaTeX format
* NLLS_fitting.py - Python script that performs NLLS fitting of models to the population growth dataset
* library.bib - a BibTex file that contains all the ritations that is used during compiling the LaTeX file
* run_MiniProject.sh - bash script that glues all scripts together under one workflow

### Data

* LogisticGrowthData.csv - raw data used for the miniproject that includes information about different bacterial species population abundances
* LogisticGrowthMetaData.csv - the metadata associated with the raw data explaining what each column represents
* ModifiedLogisticGrowthData.csv - the csv file that is exported by `Data_Preparation.R` script which includes the data wrangled version of the raw data, ready to be used for model fitting
* results.csv - includes the parameter estimates of the models and model selection criteria obtained from performing the NLLS fitting

## Packages

### R (version 3.6.0)

* dplyr - for data manipulation
* ggplot2 - for plotting

### Python (version 3.6.9)

* Pandas - for using dataframes
* NumPy - for scientific and numeric computing
* LMFIT - for NLLS fitting

## Authors

Jedi (in training): Hovig Artinian

Academic email: ha819@ic.ac.uk

Personal email: artinianhovig@gmail.com

## License

None

