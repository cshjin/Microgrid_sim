# -*- coding: utf-8 -*-
"""
Created on Sat Jan 11 13:12:51 2014

@author: Hongwei Jin
"""

import httplib
import urllib2
cont = urllib2.urlopen("http://media.iitonline.iit.edu/lectures/CS-110-01-/index.html").read()
print cont
#subs = ['BIOL']
#
#for sub in subs:
#    for i in range(500, 600):
#        conn = httplib.HTTPConnection('media.iitonline.iit.edu')
#        if len(sub) == 2:
#            url = '/lectures/'+sub+'-'+str(i)+'-01-/index.html'
#        elif len(sub) == 3:
#            url = '/lectures/'+sub+'-'+str(i)+'-01/index.html'
#        elif len(sub) == 4:
#            url = '/lectures/'+sub+'-'+str(i)+'-0/index.html'
#        #conn.request('HEAD', '/lectures/CS-480-01-/index.html')
#        conn.request('HEAD', url)
#        if conn.getresponse().status == 200:
#            print 'http://media.iitonline.iit.edu' + url
#            r = conn.getresponse()
#            print r.read()
#    print ' '