#!/bin/bash 

# Runs and profiles LV1.py, LV2.py, LV3.py, and LV4.py

# First, run the scripts
echo "Running LV1.py..."
python3 LV1.py
if [ $? ] # If script runs successfully, the stored value of $? will be 0, which makes the if statement TRUE
then
    echo -e "Script ran successfully!\n"
else
    echo -e "Script failed to run :(\n"
fi

echo "Running LV2.py..."
python3 LV2.py
if [ $? ]
then
    echo -e "Script ran successfully!\n"
else
    echo -e "Script failed to run :(\n"
fi

echo "Running LV3.py..."
python3 LV3.py
if [ $? ]
then
    echo -e "Script ran successfully!\n"
else
    echo -e "Script failed to run :(\n"
fi

echo "Running LV4.py..."
python3 LV4.py
if [ $? ]
then
    echo -e "Script ran successfully!\n"
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
