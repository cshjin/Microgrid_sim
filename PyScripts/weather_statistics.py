# ------------------------------------------------------------------------------
# A statistical model of weather conditions and weather time.
# ------------------------------------------------------------------------------
# File:         weather_statistics.py
# Author:       Hongwei Jin
# Created:      02/09/2015
# Modified:

import os
from datetime import datetime, timedelta
from collections import defaultdict, Counter, OrderedDict
import csv
import itertools

CURRENT_FOLDER = os.path.dirname(os.path.realpath(__file__))
DATA_FOLDER = os.path.join(CURRENT_FOLDER, "..", "Data\\weather_data")

_columns = defaultdict(list)


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


def get_weather_list():
    conds = sorted(list(set(_columns.get("Conditions"))))
    weather_dic = {}
    with open(os.path.join(DATA_FOLDER, "weather_conditions.txt"), "w") as outfile:
        for i in range(1, len(conds) + 1):
            outfile.write(str(i) + ", " + conds[i - 1] + "\n")
    return conds


def count_weathers():
    with open(os.path.join(DATA_FOLDER, "filtered_merged_history_KMDW.csv")) as infile:
        pass
    pass


def count_gaps():
    pass


def majority_rule():
    pass


def gap_interplation():
    pass


def read_data(filename):
    """
    Read all columns to dictionary in a inner varaiable _columns, sorted with keys
    """
    with open(os.path.join(DATA_FOLDER, filename)) as infile:
        reader = csv.DictReader(infile)  # read rows into a dictionary format
        for row in reader:  # read a row as {column1: value1, column2: value2,...}
            for (k, v) in row.items():  # go over each column name and value
                _columns[k].append(v)  # append the value into the appropriate list
    # sorted _columns by keys
    sorted(_columns, key=_columns.get)


def time_gap_stat():
    """ 
    Get a time gap list between every consecutive timestampts.
    @return {list} timestampts diffs in MINUTES
    """
    timestampts = _columns.get("DateUTC")
    # print timestampts[1]
    diffs = []
    for i in range(len(timestampts) - 1):
        diff = datetime.strptime(timestampts[i + 1].strip(), "%Y-%m-%d %H:%M:%S") - datetime.strptime(
            timestampts[i].strip(), "%Y-%m-%d %H:%M:%S")
        diffs.append(diff.total_seconds() / 60)
    dic = dict(Counter(diffs))
    # TODO: modify date type
    return sorted(dic.items())


def add_cindex_column():
    """
    Add a new column to weather data which is the index of weather conditions, starting from 1...
    """
    unique_list = sorted(list(set(_columns.get("Conditions"))))
    _columns["Cindex"] = []
    for con in _columns.get("Conditions"):
        _columns["Cindex"].append(unique_list.index(con) + 1)
    with open("_temp.txt", "w") as outfile:
        for index in _columns["Cindex"]:
            outfile.write(str(index) + "\n")
    pass

def update_csv_file():
    """
    Remove unsed columns in csv file and add new column Cindex

    TimeCST  Conditions DateUTC Cindex

    """
    add_cindex_column()
    with open(os.path.join(DATA_FOLDER, "reduced_history_KMDW.csv"), "w") as outfile:
        outfile.write("TimeCST,Conditions,DateUTC,Cindex" + "\n")
        for i in range(len(_columns["TimeCST"])):
            outfile.write(_columns["TimeCST"][i] + "," + _columns["DateUTC"][i] + "," +
                          _columns["Conditions"][i] + "," + str(_columns["Cindex"][i]) + "\n")
    pass

def transition_matrix(lst):
    """
    Count on 
    """
    conds_unique = sorted(list(set(lst)))
    # initial the possible outcomes from condition to condition
    conds_pairs = list(itertools.product(conds_unique, repeat=2))
    dic = dict((pair, 0.) for pair in conds_pairs)
    # count consecutive weather conditions
    for i in range(len(lst) - 1):
        if (lst[i], lst[i + 1]) in dic:
            dic[(lst[i], lst[i + 1])] += 1
    dic = OrderedDict(sorted(dic.items()))
    with open(os.path.join(DATA_FOLDER, "majority_matrix_prob.csv"), "w") as outfile:
        for i in conds_unique:
            row_sum = 0
            for j in conds_unique:
                row_sum += dic.get((i,j), 0)
            for j in conds_unique:
                outfile.write(str(dic.get((i,j), 0)/row_sum)+",")
            outfile.write("\n")

    return dic    
def main():
    filename = "reduced_history_KMDW.csv"
    read_data(filename)
    transition_matrix(map(int, _columns['Cindex']))

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

    # print sorted(_columns.keys())

    pass

if __name__ == '__main__':
    main()
