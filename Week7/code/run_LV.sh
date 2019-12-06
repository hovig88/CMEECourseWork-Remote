#!/bin/bash 
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: run_Vectorize.sh
# Desc: runs and profiles LV1.py, LV2.py, LV3.py, and LV4.py
# Arguments: None
# Date: Oct 2019

# First, run the scripts
echo -e "\nRunning LV1.py...\n"
python3 LV1.py
if [ $? ] # If script runs successfully, the stored value of $? will be 0, which makes the if statement TRUE
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running LV2.py...\n"
python3 LV2.py
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running LV3.py...\n"
python3 LV3.py
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "\nScript failed to run :(\n"
fi

echo -e "Running LV4.py...\n"
python3 LV4.py
if [ $? ]
then
    echo -e "\nScript ran successfully!\n"
else
    echo -e "Script failed to run :(\n"
fi

# Now, onto profiling
echo 'Profiling LV1.py :' > ../results/profiling.txt
python3 -m cProfile LV1.py >> LV1.txt && sed '3q;d' LV1.txt >> ../results/profiling.txt
echo 'Profiling LV2.py :' >> ../results/profiling.txt
python3 -m cProfile LV2.py >> LV2.txt && sed '5q;d' LV2.txt >> ../results/profiling.txt 
echo 'Profiling LV3.py :' >> ../results/profiling.txt
python3 -m cProfile LV3.py >> LV3.txt && sed '5q;d' LV3.txt >> ../results/profiling.txt
echo 'Profiling LV4.py :' >> ../results/profiling.txt
python3 -m cProfile LV4.py >> LV4.txt && sed '5q;d' LV4.txt >> ../results/profiling.txt

rm LV1.txt LV2.txt LV3.txt LV4.txt

#Print results to screen
sed 's/^[ \t]*//;s/[ \t]*$/ /' < ../results/profiling.txt | sed '$!N;s/\n//' 
# first sed command strips all whitespaces from the beginning of each line in the file
# second sed command combines every two consecutive lines together
