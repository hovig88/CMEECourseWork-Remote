# Week 2: CMEE Bootcamp: Intro to Biological Computing in Python

* The second week was an introduction to the Python program language. It covered from performing simple operations to writing scripts and programs.

* The **Week2** directory includes the following subdirectories: *code*, *data*, *results*, and *sandbox*.
    - code - includes all the Week 2 practicals/assignments and in-class scripts
    - data - includes the data needed as inputs for some of the scripts/commands
    - results - essentially an empty directory, but includes a .gitignore file (since completely empty directories cannnot be pushed to git)
    - sandbox - similar to a recycle bin; disposing files that are not needed for assessment, but might still be useful for the author if and when needed

## Contents

### Code

* align_seqs_fasta.py - aligns input fasta files and outputs the best alignment along with its score to a text file
* align_seqs.py - aligns two short sequences and outputs the best alignment along with its score to a text file
* basic_csv.py - running and handling csv files
* basic_io1.py - importing/exporting data
* basic_io2.py - importing/exporting data
* basic_io3.py - importing/exporting data
* boilerplate.py - basic python program format
* cfexercises1.py - different functions that perform conditionals with numerical operations
* cfexercises2.py - working with loops and conditionals combined
* control_flow.py - python program that shows basic control flows of programs
* debugme.py - small script that includes a bug that needs to be fixed
* dictionary.py - populates a dictionary by mapping order names to sets of taxa
* lc1.py - creates three different lists containing the latin names, common names, and mean body masses for each species in birds, respectively, using list comprehensions, as well as conventional for loops
* lc2.py - creates two different lists of month,rainfall tuples where the amount of rain was greater than 100mm and less than 50mm, respectively, using list comprehensions, as well as conventional for loops
* loops.py - working with loops
* oaks_debugme.py - python program that loops over a csv file and writes the tree species that belong to the oak tree family into a new csv file
* oaks.py - finds those taxa that are oak trees from a list of species
* scope.py - shows the different usage of local and global variables
* sysargv.py - small script to explain the concept of sys.argv
* test_control_flow.py - similar to control_flow.py, in addition to using doctests
* tuple.py - takes a tuple and outputs the rows in separate blocks according to species
* using_name.py - small script to explain why we put __name__ = "__main__"

### Data

* fasta - directory that includes 3 fasta files needed for the `align_seqs_fasta.py` script
* TestOaksData.csv - input file for the `oaks_debugme.py` program containing a list of of tree species
* bodymass.csv - output csv file by `basic_csv.py` script
* seq.csv - input csv file containing two DNA sequences needed for `align_seqs.py` program
* testcsv.csv - input csv file for `basic_csv.py` script

## Authors

Jedi (in training): Hovig Artinian

Academic email: ha819@ic.ac.uk

Personal email: artinianhovig@gmail.com

## License

None

## Acknowledgements

Second week of Jedi training completed!
