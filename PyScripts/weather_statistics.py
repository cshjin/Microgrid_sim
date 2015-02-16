# ------------------------------------------------------------------------------
# A statistical model of weather conditions and weather time.
# ------------------------------------------------------------------------------
# File:         weather_statistics.py
# Author:       Hongwei Jin
# Created:      02/09/2015
# Modified:

import os
from datetime import datetime, timedelta

CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
DATA_FOLDER = os.path.join(CURRENT_FOLDER, "..", "Data\\weather_data")

def desired_hours():
    start_date = datetime.strptime("1991-01-01", "%Y-%m-%d")
    end_date = datetime.strptime("2011-01-01", "%Y-%m-%d")
    total_hours = (end_date - start_date).days * 24
    print "There are totally {} hours from 1991-01-01 to 2010-12-31.".format(total_hours)
    return total_hours

def recored_hours():
    with open(os.path.join(DATA_FOLDER, "merged_history_KMDW.csv")) as infile:
        infile.next()
        origin_count = sum(1 for line in infile)
    print "There are totally {} records from weatherunderground.".format(origin_count)
    return origin_count

def filtered_hours():
    with open(os.path.join(DATA_FOLDER, "filtered_merged_history_KMDW.csv")) as infile:
        infile.next()
        filtered_count = sum(1 for line in infile)
    print "There are totally {} records after removing\n 'No daily or hourly history data available'\nfrom weatherunderground.".format(filtered_count)
    return filtered_count

def main():
    print "--------------------------------------------------------------------"
    t = desired_hours()
    print "--------------------------------------------------------------------"
    r = recored_hours()
    print "--------------------------------------------------------------------"
    f = filtered_hours()
    print "--------------------------------------------------------------------"
    print "There are {} days has no hourly records.".format(r-f)
    
    pass

if __name__ == '__main__':
    main()