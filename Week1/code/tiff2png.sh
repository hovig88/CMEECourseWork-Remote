#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: tiff2png.sh
# Desc: converts tiff files to png
# Arguments: none
# Date: Oct 2019

# check if there are any tiff files in the current directory
A=`find . -type f -name "*.tif" | wc -l` # the value of A will be 0 if there are no tiff files in the current directory

if [ $A ]
then
	echo "No TIFF files detected..."
	echo "Script did not execute."
	exit
fi

for f in *.tif;
	do
		echo "Converting $f";
		convert "$f" "$(basename "$f" .tif).jpg";
	done

