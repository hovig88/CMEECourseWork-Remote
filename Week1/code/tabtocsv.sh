#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"

for file in $1.csv
do
    mv "$file" "$(basename "$file" .txt.csv).csv" # fixing the file extension from .txt.csv to just .csv
done

exit

