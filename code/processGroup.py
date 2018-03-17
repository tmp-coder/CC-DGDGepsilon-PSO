# -*- coding: utf-8 -*-
"""
Created on Tue Jan 23 09:08:15 2018

@author: zhou1
"""

from queue import PriorityQueue

def solve(pri,sepSz=64):
    Q = PriorityQueue()
    for i in range(len(pri)):
        Q.put((int(pri[i]),[(i+1)]))
    while Q.qsize()>1:
        item1 = Q.get()
        item2 = Q.get()
        if item1[0]+item2[0]>sepSz:
            Q.put(item2)
            Q.put(item1)
            break
        Q.put((item1[0]+item2[0],item1[1]+item2[1]))
    ret =[]
    while not Q.empty():
        ret.append(Q.get()[1])
    #assert min(ret)>0
    return ret

solve([1000])