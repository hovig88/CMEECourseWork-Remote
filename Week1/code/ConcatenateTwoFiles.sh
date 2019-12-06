#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: concatenates two files together
# Arguments: 1 -> input file 1; 2 -> input file 2; 3 -> merged file
# Date: Oct 2019

# handling input parameters
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]
then 
    echo "Please input 3 file names..."
    echo "Script did not execute." 
    exit 
fi

cat $1 > $3 # adds contents of file 1 to empty file 3
cat $2 >> $3 # appends contents of file 2 to file 3
echo -e "\nMerged File is:\n"
cat $3 # prints out contents of file 3
echo -e "\n"
