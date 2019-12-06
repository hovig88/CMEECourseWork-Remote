#!/usr/bin/env python3

"""Using the subprocess.os module to get a list of files and directories in my ubuntu home directory"""

__appname__ = 'using_os.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

## imports ##
import subprocess

#################################
# Get a list of files and directories in your home/ that start with an uppercase 'C'

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (root, dirs, files) in subprocess.os.walk(home, topdown=True):
    for string in subprocess.os.listdir(root): # loops over the list of files and subdirectories in the current directory
        if(string.startswith('C')): # only takes files and directories that start with an upper case 'C'
            FilesDirsStartingWithC.append(string)

print("Files and directories that start with an uppercase 'C':")
print(list(set(FilesDirsStartingWithC)))
print("\n")
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithC = []

for (root, dirs, files) in subprocess.os.walk(home, topdown=True):
    for string in subprocess.os.listdir(root):
        if(string.startswith('C') or string.startswith('c')): # only takes files and directories that start with either an upper or lower case 'C'
            FilesDirsStartingWithC.append(string)

print("Files and directories that start with either an upper or lower case 'C':")
print(list(set(FilesDirsStartingWithC)))
print("\n")
#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
FilesDirsStartingWithC = []

for (root, dirs, files) in subprocess.os.walk(home, topdown=True):
        for string in dirs: # loops over the directories only so that we don't take the files into account
            if(string.startswith('C') or string.startswith('c')): # only takes directories that start with either an upper or lower case 'C'
                FilesDirsStartingWithC.append(string)

print("Directories that start with either an upper or lower case 'C':")
print(list(set(FilesDirsStartingWithC)))
