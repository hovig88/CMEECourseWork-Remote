#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: concatenates two files together
# Arguments: 1 -> input file 1; 2 -> input file 2; 3 -> merged file
# Date: Oct 2019

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3

