'''
Author: Christopher Ball
Date Created: 14/06/2016

Purpose: To calibrate using Python.
'''

import numpy as np

def GREGClean(W, C, B, L, U):
    Diff = float('inf')
    
    while np.sum(np.multiply(B - np.dot(C, W.T), B - np.dot(C, W.T))/B) < Diff:
        Tot = (B - np.dot(C, W.T)).T
        Diff = np.sum(np.multiply(Tot,Tot)/B.T)
        Mid = np.dot(np.multiply( C , np.tile(W.T, C.shape[0]).T ), C.T)
        ##W = pmax(pmin(W*(1+(Tot%*%solve(Mid))%*%C), U), L)
        W = np.multiply(W, 1 + np.dot(np.linalg.solve(Mid, Tot.T).T, C))
        W[W > U] = U
        W[W < L] = L

    return(W)

# Test example
Start = np.array([[2, 3, 4, 8]])
Char = np.array([[3, 4, 0, 2], [5, 3, 7, 2]])
Ben = np.array([[20, 50]]).T
Lower = 2
Upper = 20

Test = GREGClean(Start, Char, Ben, Lower, Upper)


