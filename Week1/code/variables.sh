#!/bin/bash
# Author: Hovig Artinian ha819@imperial.ac.uk
# Script: variables.sh
# Desc: using and reading variables in different ways
# Arguments: none
# Date: Oct 2019

# Shows the use of variables
MyVar="some string"
echo "the current value of the variable is:" $MyVar
echo "Please enter a new string"
read MyVar

if [ -z $MyVar ]
then
    echo -e "No input string provided...\n"
else
    echo "the current value of the variable is:" $MyVar
fi

## Reading multiple values
echo -e "\nEnter two numbers separated by space(s)"
read a b

if [ -z $a ] || [ -z $b ]
then
    echo "There were no input numbers provided..." 
    echo "No calculation occured."
    exit
else
    echo "you entered" $a "and" $b ". Their sum is:"
    mysum=`expr $a + $b`
    echo $mysum
fi
