#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the files with spaces
#
# Saves the output into a .txt file
# Arguments: 1 -> csv delimited file
# Date: Oct 2019

# handling input parameters
if [ -z $1 ]
then 
    echo "Please input a file name..."
    echo "Script did not execute."
    exit 
fi

filename=`basename $1`

echo "Creating a space separated version of $filename..."
cat $1 | tr -s "," " " > $filename.txt # tr -s replaces commas with spaces; even repeated commas are replaced by one space only
echo "Done!"

for file in $filename.txt
do
    mv "$file" "$(basename "$file" .csv.txt).txt" # fixing the file extension from .csv.txt to just .txt
done

