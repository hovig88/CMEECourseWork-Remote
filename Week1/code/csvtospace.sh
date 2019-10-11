#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the files with spaces
#
# Saves the output into a .txt file
# Arguments: 1 -> csv delimited file
# Date: Oct 2019

echo "Creating a space separated version of $1 ..."
cat $1 | tr -s "," " " > $1.txt # tr -s replaces commas with spaces; even repeated commas are replaced by one space only
echo "Done!"

for file in $1.txt
do
    mv "$file" "$(basename "$file" .csv.txt).txt" # fixing the file extension from .csv.txt to just .txt
done

