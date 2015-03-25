"""
    This is a function to calculate the ideal solar radiation of a perticular location
    based on its latitute and day of the year.
    Ref: http://pveducation.org/pvcdrom/properties-of-sunlight/calculation-of-solar-insolation
"""

import math


def to_rad(c):
    return c * math.pi / 180


def _declination(c):
    return 23.45 * math.sin(to_rad(360.0 / 365 * (c - 81)))


def to_deg(c):
    return 180 * c / math.pi


def AM(hour, jDay, lat):
    dec = to_rad(_declination(jDay))
    HRA = to_rad(15 * (hour - 12))
    elevation = math.asin(
        math.sin(dec) * math.sin(lat) + math.cos(dec) * math.cos(lat) * math.cos(HRA))
    declination = to_rad(90) - elevation
    return 1 / (1E-4 + math.cos(declination))


def graphHourly(jDay, lat, dec):
    x = -(math.sin(lat) * math.sin(dec))
    x = x / (math.cos(lat) * math.cos(dec))
    if x > 1.0:
        x = 1.0
    if x < -1.0:
        x = -1.0
    f = math.acos(x)
    H = to_deg(f * 1 / 15.0)

    sunrise = 12 - H
    sunset = 12 + H
    for hour in range(24):
        stot = 0
        if hour > sunrise and hour < sunset:
            am = AM(hour, jDay, lat)
            x1 = 0.7 ** am
            stot = stot + 1.353 * x1 ** 0.678
        else:
            stot = 0
        if stot > 1.1:
            stot = 0
        print stot


def cal(jDay, latitute):
    lat = to_rad(latitute)
    dec = to_rad(_declination(jDay))
    graphHourly(jDay, lat, dec)


def main():
    for i in range(1, 366):
        # calculate the ideal solar at Chicago, Chicago's latitute is approximate to 41
        cal(i, 41)

if __name__ == '__main__':
    main()
