# -*- coding: utf-8 -*-
"""
Created on Sat Mar  8 22:06:27 2014

@author: king
"""

# HLY-CLDH-NORMAL, Cooling degree hours
# HLY-HTDH-NORMAL, Heating degree hours
# HLY-PRES-10PCTL, Sea level pressure 10th percentile
# HLY-PRES-90PCTL, Sea level pressure 90th percentile
# HLY-PRES-NORMAL, Sea level pressure mean
# HLY-CLOD-PCTBKN, Clouds broken percentage
# HLY-CLOD-PCTCLR, Clouds clear percentage
# HLY-CLOD-PCTFEW, Clouds few percentage
# HLY-CLOD-PCTOVC, Clouds overcast percentage
# HLY-CLOD-PCTSCT, Clouds scattered percentage
# HLY-DEWP-10PCTL, Dew point 10th percentile
# HLY-DEWP-90PCTL, Dew point 90th percentile
# HLY-DEWP-NORMAL, Dew point mean
# HLY-HIDX-NORMAL, Heat index mean
# HLY-TEMP-10PCTL, Temperature 10th percentile
# HLY-TEMP-90PCTL, Temperature 90th percentile
# HLY-TEMP-NORMAL, Temperature mean
# HLY-WCHL-NORMAL, Wind chill mean
# HLY-WIND-AVGSPD, Average wind speed
# HLY-WIND-VCTDIR, Mean wind vector direction
# HLY-WIND-VCTSPD, Mean wind vector magnitude
# HLY-WIND-PCTCLM, Percentage calm
# HLY-WIND-1STDIR, Prevailing wind direction (1-8)
# HLY-WIND-1STPCT, Prevailing wind percentage
# HLY-WIND-2NDDIR, Secondary wind direction (1-8)
# HLY-WIND-2NDPCT, Secondary wind percentage

import csv
import json
from datetime import datetime

csv_file = open("CHI-data.csv","r")
json_file = open("new.json","w")

reader = csv.reader(csv_file)
header = reader.next()
print len(header)
for row in reader:
	row[0] = str(datetime.strptime(row[0], '%Y%m%d %H:%M'))
	print row

with open("new.csv","wb") as f:
	writer = csv.writer(f)
	for row in reader:
		writer.writerow(row)
# for row in reader:
# 	print row
# print reader.next()[0]
# timestamp = datetime.strptime(reader.next()[0], '%Y%m%d %H:%M')
# print timestamp