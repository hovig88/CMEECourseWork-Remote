#!/bin/bash
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
