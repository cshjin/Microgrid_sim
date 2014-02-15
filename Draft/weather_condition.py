# -*- coding: utf-8 -*-
"""
Created on Tue Jan 14 11:18:44 2014

@author: Hongwei Jin
"""

    import random

def cond():
    cond = random.random()
    # print cond
    normal_percent = 0.989875
    adverse_percent = 0.010011
    major_adverse_percent = 0.000114

    if cond<=normal_percent:
        return 'Normal'
    elif cond<=normal_percent+adverse_percent:
        return 'Adverse'
    elif cond<=normal_percent+adverse_percent+major_adverse_percent:
        return 'Major Adverse'
        
    
def gen_cond():
    cond_list = []
    
    for i in range(24*365):
        cond_list.append(cond())
    # cond_list.sort()
    print cond_list
    # print cond_list.sort()
    # print cond_list

def main():
    print 'gen_cond'
    gen_cond()
    
if __name__ == '__main__':
    main()