#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: CompileLaTeX.sh
# Desc: converts latex files to pdf
# Arguments: 1 -> latex file
# Date: Oct 2019

# handling input parameters
if [ -z $1 ]
then 
    echo "Please input a file name..."
    echo "Script did not execute."
    exit 
fi

# 
if [[ $1 ==  *".tex"* ]]
then 
    echo "Please input the file name without the extension..."
    echo "Script did not execute."
    exit
fi

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex

## Cleanup
rm -f *~
rm -f *.aux
rm -f *.bbl
rm -f *.blg
rm -f *.dvi
rm -f *.log
rm -f *.nav
rm -f *.out
rm -f *.snm
rm -f *.toc

# -f flag ignores nonexistent files and arguments

# move pdf file to appropriate directory
mv $1.pdf ../results
