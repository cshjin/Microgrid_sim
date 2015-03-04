# ------------------------------------------------------------------------------
# A statistical model of solar radiations
# ------------------------------------------------------------------------------
#
# File:         solar_statistics.py
# Author:       Hongwei Jin
# Created:      03/03/2015
# Modified:


import os
from datetime import datetime, timedelta
from collections import defaultdict, Counter, OrderedDict
import csv
import itertools


def read_data(folder, filename):
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


def reduce_solar_csv():
    """
    Reduce solar data file into reduced column numbers
    """
    with open(os.path.join(DATA_FOLDER, "reduce_20_years_solar_with_weathear.csv"), "w") as outfile:
        outfile.write("YYYY-MM-DD,HH:MM (LST),METSTAT Glo (Wh/m^2),Conditions,MaxRadi (Wh/m^2),Cindex,CCindex" + "\n")
        for i in range(len(_COLUMNS["YYYY-MM-DD"])):
            outfile.write(
                _COLUMNS["YYYY-MM-DD"][i] + "," +
                _COLUMNS["HH:MM (LST)"][i] + "," +
                _COLUMNS["METSTAT Glo (Wh/m^2)"][i] + "," +
                _COLUMNS["Conditions"][i] + "," +
                _COLUMNS["MaxRadi (Wh/m^2)"][i] + "," +
                _COLUMNS["Cindex"][i] + "," +
                _COLUMNS["CCindex"][i] + "\n")

def group_conditions():
    """
    List group of conditions
    """
    length = len(_COLUMNS['CCindex'])
    group = {}
    for i in range(1, 9):
        group[str(i)] = []
    for i in range(length):
        if _COLUMNS["Conditions"][i] not in group[_COLUMNS["CCindex"][i]]:
            group[_COLUMNS["CCindex"][i]].append(_COLUMNS["Conditions"][i])
    
    with open(os.path.join(DATA_FOLDER, "clustered_conditions.txt"), "w") as outfile:
        for key in group:
            outfile.write(key+":"+str(group[key])+"\n")

def transition_matrix(cindex):
    """
    Count on transition matrix based on consecutive conditions
    """
    conds_unique = sorted(list(set(cindex)))
    # initial the possible outcomes from condition to condition
    conds_pairs = list(itertools.product(conds_unique, repeat=2))
    dic = dict((pair, 0.) for pair in conds_pairs)
    # count consecutive weather conditions
    for i in range(len(cindex) - 1):
        if (cindex[i], cindex[i + 1]) in dic:
            dic[(cindex[i], cindex[i + 1])] += 1
    dic = OrderedDict(sorted(dic.items()))
    with open(os.path.join(DATA_FOLDER, "majority_matrix_prob.csv"), "w") as outfile:
        for i in conds_unique:
            row_sum = 0
            for j in conds_unique:
                row_sum += dic.get((i, j), 0)
            for j in conds_unique:
                outfile.write(str(dic.get((i, j), 0) / row_sum) + ",")
            outfile.write("\n")

def main():
    """
    Process start here
    """
    read_data(DATA_FOLDER, FILENAME)
    #----------------------------------------
    # reduce_solar_csv()
    #----------------------------------------
    # group_conditions()
    #----------------------------------------
    transition_matrix(_COLUMNS["CCindex"])

    pass

if __name__ == '__main__':
    CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
    DATA_FOLDER = os.path.join(CURRENT_FOLDER, "..", "Data\\solar_data")
    # FILENAME = "total_20_years_solar_with_weather (backup).csv"
    FILENAME = "reduce_20_years_solar_with_weathear.csv"
    _COLUMNS = defaultdict(list)
    main()
