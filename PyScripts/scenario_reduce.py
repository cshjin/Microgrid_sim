# -*- coding: utf-8 -*-
from collections import defaultdict
import csv
import numpy

def get_solar_field(fieldname):
    """
    Get the list of one column data.
    """
    columns = defaultdict(list)
    with open('solar_data\\total_20_years_solar_with_weather (backup).csv') as f:
        reader = csv.DictReader(f)  # read rows into a dictionary format
        for row in reader:  # read a row as {column1: value1, column2: value2,...}
            for (k, v) in row.items():  # go over each column name and value
                columns[k].append(v)  # append the value into the appropriate list
    return columns[fieldname]

conditions = ['Blowing Snow', 'Clear', 'Drizzle', 'Fog', 'Freezing Rain', 'Haze', 'Heavy Rain', 'Heavy Snow', 
            'Heavy Thunderstorms and Rain', 'Ice Crystals', 'Ice Pellets', 'Light Blowing Snow', 'Light Drizzle', 
            'Light Freezing Drizzle', 'Light Freezing Fog', 'Light Freezing Rain', 'Light Ice Pellets', 'Light Mist', 
            'Light Rain Showers', 'Light Rain', 'Light Snow Showers', 'Light Snow', 'Light Thunderstorms and Rain', 
            'Light Thunderstorms and Snow', 'Mist', 'Mostly Cloudy', 'Overcast', 'Partly Cloudy', 'Patches of Fog', 
            'Rain Showers', 'Rain', 'Sand', 'Scattered Clouds', 'Small Hail', 'Smoke', 'Snow Showers', 'Snow', 
            'Thunderstorm', 'Thunderstorms and Rain', 'Thunderstorms and Snow', 'Unknown', 'Volcanic Ash']

"""
Calculate the relative difference
"""
metstat_glo = get_solar_field("METSTAT Glo (Wh/m^2)")
maxradi = get_solar_field("MaxRadi (Wh/m^2)")
relative_diff = []
for i in range(len(metstat_glo)):
    if float(maxradi[i]) != 0:
        rela = abs(float(maxradi[i])-float(metstat_glo[i]))/float(maxradi[i])
        if rela >= 1:
            rela = 0
        relative_diff.append(rela)
    else:
        relative_diff.append(0)
# with open("relative_diff_unmodified.txt", "w") as outfile:
#     for i in relative_diff:
#         outfile.write(str(i)+"\n")

"""
Convert conditions to numbers
"""
cond = get_solar_field("Conditions")
# with open("conditions.txt", "w") as outfile:
#     for i in cond:
#         outfile.write(str(conditions.index(i)+1)+"\n")

"""
Calculate means
"""
matched = {}
means = {}
stddev = {}
for i in range(1, 43):
    matched[i] = []
    # means[i] = []
    # stddev[i] = []
for i in range(len(cond)):
    if relative_diff[i]!=0:
        matched[conditions.index(cond[i])+1].append(relative_diff[i])

for i in matched:
    means[i] = numpy.mean(matched[i])
    stddev[i] = numpy.std(matched[i])
print means.values()
# print stddev

