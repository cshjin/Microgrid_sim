# ------------------------------------------------------------------------------
# Plot data
#
# Author: Hongwei Jin
# Create date: 03/11/2015
# ------------------------------------------------------------------------------

from matplotlib import pyplot as plt
import numpy as np


def main():
    s1, s2 = [], []
    with open(".\\SP_2ST_42_3\\mg.out") as infile:
        for line in infile:
            s1.append(float(line.strip("\n")))
    with open(".\\SP_2ST_8_3\\mg.out") as infile:
        for line in infile:
            s2.append(float(line.strip("\n")))

    # plot data
    plt.ylabel("Cumulative Sum")
    plt.plot(np.cumsum(s1), 'r')
    plt.plot(np.cumsum(s2), 'g')
    plt.show()

if __name__ == '__main__':
    main()