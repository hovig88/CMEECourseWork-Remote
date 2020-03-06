#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: run_MiniProject.sh
# Desc: runs all scripts related to the miniproject (Data_Preparation.R, NLLS_fitting.py, Final_plotting_and_analysis.R, MiniProject_Report.tex)

# run data preparation script
echo "Running data preparation script..."

start=$(date +%s.%N)
Rscript Data_Preparation.R
end=$(date +%s.%N)
runtime=$(python3 -c "print(${end} - ${start})")
runtime1=$(echo $runtime | bc -l | xargs printf "%.3f")

echo "Done!"
echo -e "Time taken: $(echo $runtime1 | bc -l | xargs printf "%.3f") seconds\n"


# run model fitting script
echo "Running model fitting script..."

start=$(date +%s.%N)
python3 NLLS_fitting.py
end=$(date +%s.%N)
runtime=$(python3 -c "print(${end} - ${start})")
runtime2=$(echo $runtime | bc -l | xargs printf "%.3f")

echo "Done!"
echo -e "Time taken: $(echo $runtime2 | bc -l | xargs printf "%.3f") seconds\n"


# run final plotting and analysis script
echo "Running final plotting and analysis script..."

start=$(date +%s.%N)
Rscript Final_plotting_and_analysis.R
end=$(date +%s.%N)
runtime=$(python3 -c "print(${end} - ${start})")
runtime3=$(echo $runtime | bc -l | xargs printf "%.3f")

echo "Done!"
echo -e "Time taken: $(echo $runtime3 | bc -l | xargs printf "%.3f") seconds\n"


# compile LaTeX-formatted report
echo "Compiling the LaTeX-formatted report..."

start=$(date +%s.%N)

# calculate the word count of the report and save it 
texcount -1 MiniProject_Report.tex > texcount.sum
cat texcount.sum | head -c 4 > texcount2.sum

# compile LaTeX-formatted report including the word count
bash CompileLaTeX.sh MiniProject_Report > trash.txt

# remove unnecessary files
rm trash.txt
rm texcount.sum
rm texcount2.sum

end=$(date +%s.%N)
runtime=$(python3 -c "print(${end} - ${start})")
runtime4=$(echo $runtime | bc -l | xargs printf "%.3f")

echo "Done!"
echo -e "Time taken: $(echo $runtime4 | bc -l | xargs printf "%.3f") seconds\n"

# completed! print total time taken
echo "Report complete!"
echo "Total time taken: $(awk "BEGIN {print $runtime1+$runtime2+$runtime3+$runtime4; exit}") seconds"
