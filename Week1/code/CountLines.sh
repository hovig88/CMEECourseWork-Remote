#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: CountLines.sh
# Desc: counts the number of lines in a file
# Arguments: 1 -> input file
# Date: Oct 2019

# handling input parameters
if [ -z $1 ]
then 
    echo "Please input a file name..."
    echo "Script did not execute."
    exit 
fi

NumLines=`wc -l < $1` # counts number of lines and stores value in NumLines
filename=`basename $1`

echo -e "\nThe file ${filename} has $NumLines lines.\n"
