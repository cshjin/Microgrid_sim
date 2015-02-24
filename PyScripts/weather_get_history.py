# ------------------------------------------------------------------------------
# This is simple function to get the weather data from weather underground,
#   and it will get the weather from 1991-01-01 to 2010-12-31 with totally
#   20 years.
#
# The URL request sample will be like:
#   http://www.wunderground.com/history/airport/KMDW/1991/01/01/DailyHistory.html?format=1
# replace 1991 01 01 with specified YEAR, MONTH and DATE.
#
# SAMPLE output:
# TimeCST,TemperatureF,Dew PointF,Humidity,Sea Level PressureIn,VisibilityMPH,Wind Direction,Wind SpeedMPH,Gust SpeedMPH,PrecipitationIn,Events,Conditions,WindDirDegrees,DateUTC
# 12:00 AM,12.0,6.1,77,30.43,15.0,South,13.8,-,N/A,,Partly Cloudy,190,1991-01-01 06:00:00
# 1:00 AM,12.9,5.0,71,30.40,10.0,South,16.1,-,N/A,,Mostly Cloudy,190,1991-01-01 07:00:00
# ...
# 10:00 PM,19.9,18.0,92,30.30,10.0,WSW,6.9,-,N/A,,Clear,240,1991-01-02 04:00:00
# 11:00 PM,16.0,15.1,96,30.32,8.0,SW,6.9,-,N/A,,Clear,220,1991-01-02 05:00:00
#
# NOTE:
#   1. TimeCST are not separated one hour by hour;
#   2. It is not guaranteed that there are 24 tuples for each day.
# ------------------------------------------------------------------------------

# File:         weather_get_history.py
# Author:       Hongwei Jin
# Created:      02/02/2015
# Modified:     02/10/2015

import json
import urllib
import os
from datetime import datetime, timedelta
import csv
from dateutil import tz
import tempfile
from pylab import plotfile, show, gca
import matplotlib.cbook as cbook
from collections import defaultdict, Counter

START_DATE = datetime.strptime("1991-01-01", "%Y-%m-%d")
END_DATE = datetime.strptime("2011-01-01", "%Y-%m-%d")
API = "2f060cf5d6061a63"  # weather underground API
CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
# CURRENT_FOLDER = tempfile.mkdtemp()
# CURRENT_FOLDER = os.path.abspath("c:\\users\\hongwe~1\\appdata\\local\\temp\\tmppemjrz")
# DATA_FOLDER = os.path.join(CURRENT_FOLDER, "meta_data")
if not os.path.exists(os.path.join(CURRENT_FOLDER, "..\\Data\\weather_data\\KMDW")):
    os.mkdir(os.path.join(CURRENT_FOLDER, "weather_data"))
    META_DATA_FOLDER = os.mkdir(
        os.path.join(CURRENT_FOLDER, "weather_data", "KMDW"))
META_DATA_FOLDER = os.path.join(CURRENT_FOLDER, "weather_data", "KMDW")


def get_history_using_HTTP():
    ''' 
    Get Historical Weather Data through HTTP 
    '''
    num_days = (END_DATE - START_DATE).days
    work_day = START_DATE

    # @TODO: use multi thread to download weather data if possible.
    for i in range(num_days):
        y = work_day.year
        m = "%02d" % work_day.month
        d = "%02d" % work_day.day
        address = "http://www.wunderground.com/history/airport/KMDW/{}/{}/{}/DailyHistory.html?format=1".format(
            y, m, d)
        filename = os.path.join(
            META_DATA_FOLDER, "wunderground_{}_{}_{}.csv".format(y, m, d))
        urllib.urlretrieve(address, filename)
        outfile = ""
        with open(filename, "r") as infile:
            infile.readline()
            for line in infile:
                line = line.replace("<br />", "")
                outfile += line
        with open(filename, "w") as inputFile:
            inputFile.write(outfile)
        work_day = work_day + timedelta(days=1)


def merge_files():
    """
    Merge daily historical weather data into a single one. CSV format.
    """
    # abs path of data folder
    work_folder = os.path.join(CURRENT_FOLDER, "..\\Data\\weather_data\\KORD")
    file_list = os.listdir(work_folder)
    with open(os.path.join(work_folder, "..\\merged_history_KORD.csv"), "w") as outfile:
        for line in open(os.path.join(work_folder, file_list[0])):
            outfile.write(line)
        print "write the first line"
        for i in range(1, len(file_list)):
            with open(os.path.join(work_folder, file_list[i])) as infile:
                infile.next()
                for line in infile:
                    outfile.write(line)


def remove_lines():
    """
    Remove those lines which have no weather recorded. 

    Note: It may results in the majority rule. When filling with minutes data, 
        whose missing values may considered as incorrectly.
    """
    work_folder = os.path.join(CURRENT_FOLDER, "..\\Data\\weather_data")
    with open(os.path.join(work_folder, "filtered_merged_history_KMDW.csv"), "w") as outfile:
        with open(os.path.join(work_folder, "merged_history_KMDW.csv")) as infile:
            outfile.write(infile.next())
            for line in infile:
                if line[0].isdigit():
                    outfile.write(line)


def main():
    """ 
    File function interface
    1. Download weather data
    2. Merge into a single file
    3. Remove invalid lines in history file

    This process will end with a single file with every daily weather records and removing all its invalid data.
    """
    # get_history_using_HTTP()
    # merge_files()
    remove_lines()

if __name__ == '__main__':
    main()
