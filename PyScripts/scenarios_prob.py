# -*- coding: utf-8 -*-
# ------------------------------------------------------------------------------
# Main part of algorithm of flexible time selection method.
# ------------------------------------------------------------------------------
#
# File:         scenario_prob.py
# Author:       Hongwei Jin
# Created:      03/03/2015
# Modified:

import os
from datetime import datetime, timedelta
from collections import defaultdict, Counter, OrderedDict
import csv
import itertools
import numpy


def read_data(filename):
    """
    Read all columns to dictionary in a inner varaiable _COLUMNS, sorted with keys
    """
    with open(os.path.join(DATA_FOLDER, filename)) as infile:
        reader = csv.DictReader(infile)  # read rows into a dictionary format
        for row in reader:  # read a row as {column1: value1, column2: value2,...}
            for (k, v) in row.items():  # go over each column name and value
                _COLUMNS[k].append(v)  # append the value into the appropriate list
    # sorted _COLUMNS by keys
    sorted(_COLUMNS, key=_COLUMNS.get)

def cal_prob(time, cond):
    pass


def gen_prob():
    current_date, current_time, current_cond = "01-01", "14:00", "2"
    date = _COLUMNS["YYYY-MM-DD"]
    time = _COLUMNS["HH:MM (LST)"]
    CCindex = _COLUMNS["CCindex"]
    solar_radiation = _COLUMNS["METSTAT Glo (Wh/m^2)"]
    matched_index = []
    print date[10]
    for i in range(len(date)):
        if date[i][-5:] == current_date and time[i].zfill(5) == current_time:
            matched_index.append(i)

    flexible_index = []
    for i in matched_index:
        flexible_index.extend([i-10*24+j*24 for j in range(20)])
    print "{} flexible timestems selected.".format(len(flexible_index))

    forecasted_cond = []
    cur_cond_indices = []
    # TODO: modify to match two hours before
    for i in flexible_index:
        if CCindex[i - 1] == current_cond:
            cur_cond_indices.append(i)
            forecasted_cond.append(CCindex[i])

    counted_cond = Counter(forecasted_cond)

    print "historical_cond: ", counted_cond
    forecasted_prob = {}
    SR = {}
    for key in counted_cond:
        forecasted_prob[key] = float(counted_cond[key]) / len(cur_cond_indices)
        SR[key] = 0
    print "with its probablity:", forecasted_prob

    for i in cur_cond_indices:
        SR[CCindex[i]] += float(solar_radiation[i])
    print "the associated SR value:", SR

    expected_SR = 0
    for key in counted_cond:
        expected_SR += forecasted_prob[key] * SR[key] / counted_cond[key]
    print "----------------"
    print "The expected solar radiation based on historical data is:", expected_SR, "Wh"

    # get the simulated load of that hour
    diff = datetime.strptime("2014-"+ current_date + " " + current_time, "%Y-%m-%d %H:%M") - datetime.strptime("2014-01-01", "%Y-%m-%d")
    hours = diff.total_seconds()/60/60
    
    # filename = os.path.join(os.path.join(CURRENT_FOLDER, "wind_data", "wind_data.csv"))
    # data_dic = defaultdict(list)
    # with open(filename, "r") as in_file:
    #     reader = csv.DictReader(in_file)
    #     for row in reader:
    #         for (k, v) in row.items():
    #             data_dic[k].append(v)
    # spd = float(data_dic["Wind speed"][int(hours)+1])
    # print "----------------"
    # print "The energy can get from wind turbine is: ", 1.0/2*1.27*3.14*25*spd**3*0.5, "Wh"

    # filename = os.path.join(os.path.join(CURRENT_FOLDER, "load_data", "E_PLUS_RESI_TMY3_Load.csv"))
    # data_dic = defaultdict(list)
    # with open(filename, "r") as in_file:
    #     reader = csv.DictReader(in_file)
    #     for row in reader:
    #         for (k, v) in row.items():
    #             data_dic[k].append(v)
    # print "----------------"
    # print "The simulated load energy of a single residental house will be ", float(data_dic["load"][int(hours)+1])*1000, "Wh"
    pass

def main():
    filename = "solar_weather.csv"
    read_data(filename)
    gen_prob()

    pass

if __name__ == '__main__':
    CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
    DATA_FOLDER = os.path.join(CURRENT_FOLDER, "..", "Data\\combined_data")
    _COLUMNS = defaultdict(list)

    main()
