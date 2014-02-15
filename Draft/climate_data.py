# -*- coding: utf-8 -*-
"""
Created on Sat Jan 18 14:44:38 2014

@author: Hongwei Jin
"""

import urllib
import matplotlib
import csv
import re
from time import gmtime, strftime
time = strftime("%Y%m%d")
#time = "20140118"
url = "http://www.glerl.noaa.gov/metdata/chi/2014/"+time+".04t.txt"
html_file = urllib.urlopen(url)
#html_text = html_file.readline()
#print html_text
#if html_file.readline().startswith(' '):
#    print "ignore"

for line in html_file.readlines():
    if line[0].isdigit():
        continue
    print line
    line.split()
#print lines