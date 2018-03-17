# -*- coding: utf-8 -*-
"""
Created on Mon Jan 22 11:53:05 2018

@author: zouzhitao
"""

import os
import re
import time
import sys
path = 'code'

def modifyMain(funcIdx,funcRange):
    name = 'main%d.m'%(funcIdx)
    filename = os.path.join(path,name)
    if os.path.exists(filename):
        return
    fw = open(filename,'w')
    fileRead = os.path.join(path,'main.m')
    with open(fileRead,'r') as fr:
        for s in fr.readlines():
            if s[:5]=='costf':
                s = (s[:6]+"\'F%d\';\n")%(funcIdx)
            if s[:5]=='range':
                s = (s[:6])+str(funcRange)+';\n'
            fw.write(s);
    fw.close();
    
def modifyPBS(funcIdx):
    writeFile = 'test%d.pbs'%(funcIdx)
    if os.path.exists(writeFile):
        return writeFile
    fw = open(writeFile,'w')
    pat1 = 'CC_PSO_F'
    pat2 = 'main'
    with open('test.pbs','r') as fr:
        for lines in fr.readlines():
            s = lines
            if lines.find(pat1)!=-1:
                s = re.sub(pat1+(r'\d*'),pat1+str(funcIdx),lines)
            if lines.find(pat2)!=-1:
                s = re.sub(pat2+(r'\d*'),pat2+str(funcIdx),lines)
            fw.write(s)
    fw.close()
    return writeFile

funcRange = [0,100,5,32,100,5,32,100,100,100,5,32,100,100,100,5,32,100,100,100,100]

def main(begin=1,end = 21):
    for i in range(begin,end):
        modifyMain(i,funcRange[i])
        name = modifyPBS(i)
        cmd = 'qsub '+name
        os.system(cmd)
        time.sleep(10)
        
if __name__=='__main__':
    begin=1
    end = 21
    try:
        begin = int(sys.argv[1])
        end = int(sys.argv[2])
    except:
        end= 21
    main(begin,end)
    
    