# -*- coding: utf-8 -*-
# ------------------------------------------------------------------------------
# A statistical model of weather conditions and weather time.
# ------------------------------------------------------------------------------
# Processing steps:
#   * read data to dic from merged_history_KMDW.csv (1)
#   * from (1) file, remove unrecord data lines, remove duplicated lines, and save to filtered_history_KMDW.csv (2)
#   * from (2) file, remove unused columns and save to reduced_history_KMDW.csv
#
#
#
# File:         weather_statistics.py
# Author:       Hongwei Jin
# Created:      02/09/2015
# Modified:     03/02/2015

import os
from datetime import datetime, timedelta
from collections import defaultdict, Counter, OrderedDict
import csv
import itertools


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
    print "There are totally {} records after removing\n\
        'No daily or hourly history data available'\n\
        from weatherunderground.".format(filtered_count)
    return filtered_count


def get_weather_list():
    conds = sorted(list(set(_COLUMNS.get("Conditions"))))
    weather_dic = {}
    with open(os.path.join(DATA_FOLDER, "weather_conditions.txt"), "w") as outfile:
        for i in range(1, len(conds) + 1):
            outfile.write(str(i) + ", " + conds[i - 1] + "\n")
    return conds


def majority_rule():
    pass


def gap_interplation():
    pass


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


def time_gap_stat():
    """ 
    Get a time gap list between every consecutive timestamps.
    @return {list} timestamps diffs in MINUTES
    """
    timestamps = _COLUMNS.get("DateUTC")
    # print timestamps[1]
    diffs = []
    for i in range(len(timestamps) - 1):
        diff = datetime.strptime(timestamps[i + 1].strip(), "%Y-%m-%d %H:%M:%S") - datetime.strptime(
            timestamps[i].strip(), "%Y-%m-%d %H:%M:%S")
        diffs.append(diff.total_seconds() / 60)
    dic = dict(Counter(diffs))
    # TODO: modify date type
    return sorted(dic.items())


def add_cindex_column():
    """
    Add a new column to weather data which is the index of weather conditions, starting from 1...
    """
    unique_list = sorted(list(set(_COLUMNS.get("Conditions"))))
    _COLUMNS["Cindex"] = []
    for con in _COLUMNS.get("Conditions"):
        _COLUMNS["Cindex"].append(unique_list.index(con) + 1)
    with open("_temp.txt", "w") as outfile:
        for index in _COLUMNS["Cindex"]:
            outfile.write(str(index) + "\n")
    pass


def update_csv_file():
    """
    Remove unsed columns in csv file and add new column Cindex

    TimeCST  Conditions DateUTC Cindex

    """
    add_cindex_column()
    with open(os.path.join(DATA_FOLDER, "reduced_history_KMDW.csv"), "w") as outfile:
        outfile.write("TimeCST,DateUTC,Conditions,,Cindex" + "\n")
        for i in range(len(_COLUMNS["TimeCST"])):
            outfile.write(_COLUMNS["TimeCST"][i] + "," + _COLUMNS["DateUTC"][i] + "," +
                          _COLUMNS["Conditions"][i] + "," + str(_COLUMNS["Cindex"][i]) + "\n")
    pass


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


def majority_rule():
    """
    Apply majority_rule to match data exactly each one hour
    """
    # TODO: more efficient implementation
    timestamps = _COLUMNS.get("DateUTC")
    data_dic = _COLUMNS
    # print timestamps[1]
    for i in range(len(timestamps) - 1, 0, -1):
        print i
        ts1 = data_dic["DateUTC"][i - 1]
        ts2 = data_dic["DateUTC"][i]
        first = datetime.strptime(ts1, "%Y-%m-%d %H:%M:%S")
        second = datetime.strptime(ts2, "%Y-%m-%d %H:%M:%S")
        diff = second - first
        interval_size = diff.total_seconds() / 60
        if interval_size > 1:
            new_time_lst = [(first + timedelta(minutes=1) * step).strftime("%Y-%m-%d %H:%M:%S")
                            for step in range(1, int(interval_size))]
            [data_dic["DateUTC"].insert(i + j, item) for j, item in enumerate(new_time_lst)]
            [data_dic["Conditions"].insert(i, data_dic["Conditions"][i - 1]) for j in range(len(new_time_lst))]


def main():
    filename = "merged_history_KMDW.csv"
    filename = "filtered_merged_history_KMDW.csv"
    filename = "reduced_history_KMDW.csv"

    read_data(DATA_FOLDER, filename)

    # print _COLUMNS['DateUTC']
    ##
    # transition_matrix(map(int, _COLUMNS['Cindex']))

    # print time_gap_stat()
    # update_csv_file()

    # conds = get_weather_list()
    # print conds
    # print len(conds)
    # with open(os.path.join(DATA_FOLDER, "conditions_list.txt"), "w") as outfile:
    #     for i in conds:
    #         outfile.write(i+"\n")
    # print "--------------------------------------------------------------------"
    # t = desired_hours()
    # print "--------------------------------------------------------------------"
    # r = recored_hours()
    # print "--------------------------------------------------------------------"
    # f = filtered_hours()
    # print "--------------------------------------------------------------------"
    # print "There are {} days has no hourly records.".format(r - f)

    # print sorted(_COLUMNS.keys())


if __name__ == '__main__':
    CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
    DATA_FOLDER = os.path.join(CURRENT_FOLDER, "..", "Data\\weather_data")
    _COLUMNS = defaultdict(list)

    main()
