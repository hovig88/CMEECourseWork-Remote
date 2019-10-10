#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: CountLines.sh
# Desc: counts the number of lines in a file
# Arguments: 1 -> input file
# Date: Oct 2019

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo

