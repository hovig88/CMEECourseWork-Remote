#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: run_Vectorize.sh
# Desc: runs Vectorize1.R, Vectorize1.py, Vectorize2.R, Vectorize2.py scripts
# Arguments: None
# Date: Oct 2019

# First, run the scripts
echo -e "\nRunning Vectorize1.R...\n"
Rscript Vectorize1.R
if [ $? ] # If script runs successfully, the stored value of $? will be 0, which makes the if statement TRUE
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running Vectorize1.py...\n"
python3 Vectorize1.py
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running Vectorize2.R...\n"
Rscript Vectorize2.R
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running Vectorize2.py...\n"
python3 Vectorize2.py
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo "Now that we have ran the scripts, let's compare their computational speeds (in seconds)..."
printf "SumAllElements function in the R script Vectorize1.R        : " && cat ../data/Vectorize1_R.txt | head -1
printf "Built-in sum function in the R script Vectorize1.R          : " && cat ../data/Vectorize1_R.txt | tail -1
printf "SumAllElements function in the Python script Vectorize1.py  : " && cat ../data/Vectorize1_py.txt | head -1
printf "Built-in sum function in the Python script Vectorize1.py    : " && cat ../data/Vectorize1_py.txt | tail -1
printf "Stochrick function in the R script Vectorize2.R             : " && cat ../data/Vectorize2_R.txt | head -1
printf "Stochrickvect function in the R script Vectorize2.R         : " && cat ../data/Vectorize2_R.txt | tail -1
printf "Stochrick function in the Python script Vectorize2.py       : " && cat ../data/Vectorize2_py.txt | head -1
printf "Stochrickvect function in the Python script Vectorize2.py   : " && cat ../data/Vectorize2_py.txt | tail -1
echo -e "\n"
