#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: run_get_TreeHeight.sh
# Desc: runs get_TreeHeight.R and get_TreeHeight.py scripts
# Arguments: trees.csv
# Date: Oct 2019

echo -e "\nRunning R script...\n"
Rscript get_TreeHeight.R ../data/trees.csv

if [ $? ] # If script runs successfully, the stored value of $? will be 0, which makes the if statement TRUE
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running python script...\n"
python3 get_TreeHeight.py ../data/trees.csv

if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi
