# -*- coding: utf-8 -*-
"""
Created on Tue Jan 21 16:18:03 2014

@author: Hongwei Jin
"""

from BeautifulSoup import BeautifulSoup as BS
import urllib2
html = urllib2.urlopen('http://www.weather.com/weather/today/60616')
soup = BS(html)
elem = soup.findAll('div',{"class":"wx-wind-label"})
print elem[0].text
elem = soup.findAll('span',{"itemprop":"temperature-fahrenheit"})
print elem[0].text