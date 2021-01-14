#!C:\Python\Python
#coding=utf-8

import time
import random 

def waitingGame ():
    target = random.randint(2,4)
    print('\nYour target is {} seconds'.format(target))
    input(' --- Press Enter to begin ---')
    start = time.perf_counter()
    
    input('\n... Press Enter again after {} seconds...'.format(target))
    elapsed = time.perf_counter() - start 
    
    print('\nElapsed Time is: {0: .3f} seconds'.format(elapsed))
    
    if elapsed == target:
        print('Success!!!!')
    elif elapsed < target:
        print('{0: .3f} seconds too fast'.format(target-elapsed))
    else :
        print('{0: .3f} seconds too fast'.format(elapsed-target))


waitingGame()

