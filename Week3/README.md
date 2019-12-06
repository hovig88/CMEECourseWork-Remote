# Week 3: CMEE Bootcamp: Biological Computing in R

* The third week was an introduction to the R programming language. It covered from performing simple operations, writing scripts and functions, data management, and data visualization.

* The **Week3** directory includes the following subdirectories: *code*, *data*, *results*, and *sandbox*.
    - code - includes all the Week 3 practicals/assignments and in-class scripts
    - data - includes the data needed as inputs for some of the scripts/commands
    - results - essentially an empty directory, but includes a .gitignore file (since completely empty directories cannnot be pushed to git)
    - sandbox - similar to a recycle bin; disposing files that are not needed for assessment, but might still be useful for the author if and when needed

## Contents

### Code

* apply1.R - application on the apply function
* apply2.R - application on the apply function
* Autocorrelation.tex - LaTeX format file that can be compiled to a pdf format using the `CompileLaTeX.sh` bash script from the `Week1` directory
* basic_io.R - illustrates R input-output
* boilerplate.R - basic boilerplate R script
* break.R - basic usage of break
* browse.R - basic usage of the browser function for debugging
* control_flow.R - basic control flow R script
* DataWrang.R - basic data management and wrangling workflow
* DataWrangTidy.R - basic data management and wrangling workflow using dplyr and tidyr
* get_TreeHeights.py - A python version of `get_TreeHeight.R`
* get_TreeHeights.R - A generic version of `TreeHeight.R`, where it takes any input file as a dataset
* Girko.R - plots the Girko's law simulation and saves it to a pdf file
* GPDD_Data.R - mapping the Global Population Dynamics Database (GPDD)
* MyBars.R - using ggplot geom text to annotate plot
* next.R - basic usage of the next function
* plotLin.R - annotates a plot and saves it to a pdf file
* PP_Lattice.R - this script creates three lattice graphs by feeding interaction type for predator mass, prey mass, and size ratio of prey mass over predator mass. It also calculates the mean and median predator mass, prey mass, and size rato to a csv file
* PP_Regress_loc.R - similar to the PP_Regress.R script, with the addition of the Location parameter
* PP_Regress.R - this script draws and saves a pdf file of an exact copy of a figure found in the chapter, and writes the accompanying regression results to a formatted table in csv
* preallocate.R - using preallocation approach to speed up for loops
* Ricker.R - runs a simulation of the Ricker model and returns a vector of length generations
* run_get_TreeHeight.sh - runs get_TreeHeight.R and get_TreeHeight.py scripts
* sample.R - an example of vectorization involving `lapply` and `sapply`
* TAutoCorr.R - this script calculates the coefficients of temperature correlations between successive years
* TreeHeight.R - This function calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula 
* try.R - debugging with try function
* Vectorize1.py - a python version of `Vectorize1.R`
* Vectorize1.R - an example of how usnig a vectorization approach can enhance the speed of a script
* Vectorize2.py - a python version of Vectorize2.R
* Vectorize2.R - runs the stochastic Ricker equation with gaussian fluctuations

### Data

* EcolArchives-E089-51-D1.csv - a dataset on Consumer-Resource (e.g., Predator-Prey) body mass ratios taken from the Ecological Archives of the ESA (Barnes et al. 2008, Ecology 89:881). 
* GPDDFiltered.RData - a filtered dataset of the Global Population Dynamics Database (GPDD).
* KeyWestAnnualMeanTemperature.RData - a dataset with temperatures in Key West, Florida for the 20th century
* PoundHillData.csv - a dataset on cultivation treatments applied in three months: october, may, march
* PoundHillMetaData.csv - metadata on the `PoundHillData.csv` dataset
* Results.txt - some data used in the `MyBars.py` script to show how plot annotation is done
* trees.csv - a dataset of tree species with their corresponding degrees (angle of elevation of tree) and distance (distance from base of tree in meters)

## Authors

Jedi (in training): Hovig Artinian

Academic email: ha819@ic.ac.uk

Personal email: artinianhovig@gmail.com

## License

None

## Acknowledgements

Third week of Jedi training completed!
