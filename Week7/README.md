# Week 7: Biological Computing in Python II

* The seventh week  was a continuation to the Intro Python Week. The overall aims,format, and venue of the lectures and practicals were the same as that Python-focused Bootcamp week.

* The **Week7** directory includes the following subdirectories: *code*, *data*, *results*, and *sandbox*.
    - code - includes all the Week 7 practicals/assignments and in-class scripts
    - data - includes the data needed as inputs for some of the scripts/commands
    - results - essentially an empty directory, but includes a .gitignore file (since completely empty directories cannnot be pushed to git)
    - sandbox - similar to a recycle bin; disposing files that are not needed for assessment, but might still be useful for the author if and when needed

## Contents

### Code

#### In-class scripts

* profileme.py - Some functions to explain the concept of profiling in Python
* profileme2.py - Some functions to explain the concept of profiling in Python. Improving the functions in `profileme.py` to make them less time-consuming
* timeitme.py - Comparing run time for using loops vs list comprehensions and loops vs the join method utilizing the timeit module
* Nets.R - Visualizing the QMEE CDT collaboration network, coloring the nodes by the type of organization
* fmr.R - Plotting log(field metabolic rate) against log(body mass) for the Nagy et al 1999 dataset to a pdf file
* regexs.py - Various usage of regex functions in python
* TestR.R - test R script to be used in python
* TestR.py - test python script that runs `TestR.R` using the `subprocess` module

#### Practicals

* LV1.py - Calculating the consumer-resource population growth rate and producing two different plots using both consumer and resource density curves
* LV2.py - Similar to `LV1.py` with the addition of prey density dependence in the model
* LV3.py - A discrete-time version of the Lotka-Volterra model implemented in `LV2.py`
* LV4.py - A version of the discrete-time model, implemented in `LV3.py`, simulation with a random gaussian fluctuation in resource's growth rate at each time-step
* DrawFW.py - Building a food web network by generating an adjacency list and a matrix of species names/ids and properties, and saving the network plot to a pdf file
* Nets.py - A python version of the network created in `Nets.R`
* blackbirds.py - Printing out Kingdom, Phylum, and Species names for each species found in the `blackbirds.txt` file
* using_os.py



### Data

## Authors

Jedi (in training): Hovig Artinian

Academic email: ha819@ic.ac.uk

Personal email: artinianhovig@gmail.com

## License

None

## Acknowledgements

Seventh week of Jedi training completed!
