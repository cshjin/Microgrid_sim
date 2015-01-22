# ------------------------------------------------------------------------------
# This is a file to generate hourly electricity price base on the reference:
#   http://tcipg.mste.illinois.edu/sites/default/files/files/applets/tou_lessons.pdf
#
# Time of Use Pricing:
# Summer(May 1 - October 31):
#       Peak            Mid-peak(shoulder)          Off-peak
#       11-17           7-11, 17-21                 21-7
# Winter(November 1 - April 30):
#       Peak            Mid-peak(shoulder)          Off-peak
#       7-11, 17-21     11-17                       21-7
# Weekends and Statutory Holidays(Option):
#       Off-peak
#       All day long
#
# ------------------------------------------------------------------------------

# File:         generate_buying_price.py
# Author:       Hongwei Jin
# Created:      01/21/2015
# Modified:

from datetime import datetime, timedelta

# DEFINE MACRO VARIABLES
OFFPEAK = 0.051
MIDPEAK = 0.081
ONPEAK = 0.099


def tou(month, weekday, hour):
    """ Calculate TOU pricing
    """
    if weekday in [0, 6]:
        return OFFPEAK
    else:
        if month in [5, 6, 7, 8, 9, 10]:
            if hour in [11, 12, 13, 14, 15, 16]:
                return ONPEAK
            elif hour in [7, 8, 9, 10, 17, 18, 19, 20]:
                return MIDPEAK
            else:
                return OFFPEAK
        else:
            if hour in [11, 12, 13, 14, 15, 16]:
                return MIDPEAK
            elif hour in [7, 8, 9, 10, 17, 18, 19, 20]:
                return ONPEAK
            else:
                return OFFPEAK


def main():
    """ write data to BuyPricing.txt
    """
    YEAR = 2015
    date = datetime(YEAR, 1, 1)
    price_list = []
    for i in range(8760):
        price_list.append(tou(date.month, int(date.strftime("%w")), date.hour))
        date = date + timedelta(hours=1)
    with open("..\\Data\\BuyingPrice.txt", "w") as out_file:
        for i in price_list:
            out_file.write(str(i) + "\n")
    with open("..\\Data\\SellingPrice.txt", "w") as out_file:
        for i in price_list:
            out_file.write(str(i * 0.8) + "\n")

if __name__ == '__main__':
    main()
