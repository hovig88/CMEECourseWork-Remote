# Week 1: Course Induction & CMEE Bootcamp Intro

* The first week was an induction to the CMEE Masters program and an introduction to the Unix environment, shell scripting, version control with git, and typesetting with LaTeX.

* The **Week1** directory includes a `.gitignore` file and the following subdirectories: *Code*, *Data*, *Results*, and *Sandbox*.
    - Code - includes all the scripts and commands related to the Week 1 practicals/assignments
    - Data - includes the data needed as inputs for some of the scripts/commands
    - Results - essentially an empty directory, but includes an empty `.keep` file (since completely empty directories cannnot be pushed to git)
    - Sandbox - similar to a recycle bin; disposing files that are not needed for assessment, but might still be useful for the author if and when needed

## Contents

### Code

#### Unix

* UnixPrac1.txt - includes 5 single-line commands answering the fasta exercise questions

#### Shell scripting

* boilerplate.sh - prints a simple sentence
* ConcatenateTwoFiles.sh - merges two input files into one
* CountLines.sh - counts the number of lines of an input file
* csvtospace.sh - converts an input csv delimited file to space delimited
* MyExampleScript.sh - shows the basic usage of variables
* tabtocsv.sh - converts an input tab delimited file to comma delimited
* tiff2png.sh - converts all tiff files to png
* variables.sh - another demonstration of basic usage of variables

#### Scientific documents with LaTeX

* CompileLaTeX.sh - compiles an input LaTeX file into a pdf
* FirstBiblio.bib - BibTeX file (reference) needed to compile the pdf file
* FirstExample.tex - LaTeX format file that serves as an input for `CompileLaTeX.sh` script

### Data

* fasta - directory that includes 3 fasta files needed for the `UnixPrac1.txt` file (fasta exercise)
* Temperatures - directory that includes 4 csv input files used for `csvtospace.sh` script

## Authors

Jedi (in training): Hovig Artinian

Academic email: ha819@ic.ac.uk

Personal email: artinianhovig@gmail.com

## License

None

## Acknowledgements

First week of Jedi training completed!
