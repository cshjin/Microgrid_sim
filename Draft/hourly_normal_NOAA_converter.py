import csv
import json

csv_file = open("298048.csv","r")
json_file = open("new.json","w")

field_name = ("HLY-TEMP-NORMAL")
reader = csv.DictReader(csv_file, field_name)
for row in reader:
	json.dump(row, json_file,indent = 4)
	json_file.write('\n')