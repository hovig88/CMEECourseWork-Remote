#!/usr/bin/env python3

"""Various usage of regex functions in python"""

__appname__ = 'regexs.py'
__author__ = 'Hovig Artinian (ha819@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = 'None'

## imports ##
import re

my_string = "a given string"
match = re.search(r'\s', my_string) # matches spaces
print(match)
match.group()

match = re.search(r'\d', my_string) # matches digits
print(match)

# to know whether a pattern was matched
MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) # matches 0 or more characters until it matches a space

if match:
    print('found a match:', match.group())
else:
    print('did not find a match')

# some more regex
match = re.search(r'2', "it takes 2 to tango") # matches the digit 2
match.group()

match = re.search(r'\d', "it takes 2 to tango") # matches a digit
match.group()

match = re.search(r'\d.*', "it takes 2 to tango") # matches a digit and everything after it
match.group()

match = re.search(r'\s\w{1,3}\s', 'once upon a time') # matches words that are 1 to 3 characters long and precede and are preceded by spaces
match.group()

match = re.search(r'\s\w*$', 'once upon a time') # $ matches the end of the string
match.group()

# a more compact syntax
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()
# 'take 2 grams of H2'

re.search(r'^\w*.*\s', 'once upon a time').group()
# 'once upon a '

re.search(r'^\w*.*?\s', 'once upon a time').group() # ? matches the preceding element 0 or 1 time
# 'once '

re.search(r'<.+>', 'This is a <EM>first<EM> test').group()
# '<EM>first<EM>' ~ greediness

re.search(r'<.+?>', 'This is a <EM>first<EM> test').group()
# '<EM>' - . matches E, + matches M and onward but since we have a ?, it matches only M

re.search(r'\d*\.?\d*', '1432.75+60.22i').group() # \. to match . and not its special significance in regex
# '1432.75'

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()
# 'ATTCGT'

re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()
# ' Theloderma asper'

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r'[\w\s]+,\s[\w\.@]+,\s[\w\s]+', MyStr)
match.group()
# 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
#match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
#match.group()
#---------------------------------------------------------------------------
#AttributeError                            Traceback (most recent call last)
#<ipython-input-275-35a2dcba41c5> in <module>()
#      1 match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
#----> 2 match.group()
#
#AttributeError: 'NoneType' object has no attribute 'group'

match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()
# 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
