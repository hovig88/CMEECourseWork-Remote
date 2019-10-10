#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: tiff2png.sh
# Desc: converts tiff files to png
# Arguments: none
# Date: Oct 2019

for f in *.tif;
	do
		echo "Converting $f";
		convert "$f" "$(basename "$f" .tif).jpg";
	done