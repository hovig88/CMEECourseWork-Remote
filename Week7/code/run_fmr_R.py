#!/usr/bin/env python3

"""Python script that runs fmr.R using the subprocess module"""

__appname__ = 'DrawFW.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import subprocess

p = subprocess.Popen(["Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout"], stdout = subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
stdout, stderr = p.communicate()

if stderr == b'':
    print("R script ran successfully!")
