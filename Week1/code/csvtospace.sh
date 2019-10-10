#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the files with spaces
#
# Saves the output into a .txt file
# Arguments: 1 -> csv delimited file
# Date: Oct 2019

echo "Creating a space separated version of $1 ..."
cat $1 | tr -s "," " " > $1.txt
echo "Done!"