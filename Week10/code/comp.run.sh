#!/bin/bash

# compiles C program:
gcc -Wall $1
error=$?

if [ $error != 0 ]
then
    echo "Fix errors to obtain output"

else
    # run the program:
    ./a.out

fi
