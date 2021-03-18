#!C:\Anaconda3\python.exe
#coding=utf-8

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

# Vectors. creating array.
a = np.array([1,2,3,4])
b = np.array((0, 1, 2, 3, 4))
c = np.arange(5)
d = np.linspace(0, 2*np.pi, 5)

print(a)
print(b)
print(c)
print(d)

a = np.zeros((2,2))   # Create an array of all zeros
print(a)              # Prints "[[ 0.  0.]
                      #          [ 0.  0.]]"

b = np.ones((1,2))    # Create an array of all ones
print(b)              # Prints "[[ 1.  1.]]"

c = np.full((2,2), 7)  # Create a constant array
print(c)               # Prints "[[ 7.  7.]
                       #          [ 7.  7.]]"

d = np.eye(4)         # Create a 2x2 identity matrix
print(d)              # Prints "[[ 1.  0.]
                      #          [ 0.  1.]]"

e = np.random.random((2,2))  # Create an array filled with random values
print(e)                     # Might print "[[ 0.91940167  0.08143941]
                             #               [ 0.68744134  0.87236687]]"

a = np.array([[1,2], [3, 4], [5, 6]])

# 两个对齐的数组形成的索引
# An example of integer array indexing.
# The returned array will have shape (3,) and
print(a[[0, 1, 2], [0, 1, 0]])  # Prints "[1 4 5]"

# The above example of integer array indexing is equivalent to this:
print(np.array([a[0, 0], a[1, 1], a[2, 0]]))  # Prints "[1 4 5]"

# When using integer array indexing, you can reuse the same
# element from the source array:
print(a[[0, 0], [1, 1]])  # Prints "[2 2]"

# Equivalent to the previous integer array indexing example
print(np.array([a[0, 1], a[0, 1]]))  # Prints "[2 2]"
exit()


# Matrices. 2D array
a = np.array([[11, 12, 13, 14, 15],
              [16, 17, 18, 19, 20],
              [21, 22, 23, 24, 25],
              [26, 27, 28 ,29, 30],
              [31, 32, 33, 34, 35]])
			  
print(a[2,4])
print(a[0, 1:4]) # >>>[12 13 14]
print(a[1:4, 0]) # >>>[16 21 26]
print(a[::2,::2]) # >>>[[11 13 15]
                  #     [21 23 25]
                  #     [31 33 35]]
print(a[:, 1]) # >>>[12 17 22 27 32]

# atrributes
print(type(a)) # >>><class 'numpy.ndarray'>
print(a.dtype) # >>>int64
print(a.size) # >>>25
print(a.shape) # >>>(5, 5)
print(a.itemsize) # >>>8
print(a.ndim) # >>>2
print(a.nbytes) # >>>200

# Operators 
print("== Operators ==")
a = np.arange(25)
a = a.reshape((5, 5))
print(a)

b = np.array([10, 62, 1, 14, 2, 56, 79, 2, 1, 45, 4, 92, 5, 55, 63, 43, 35, 6, 53, 24, 56, 3, 56, 44, 78])
b = b.reshape((5,5))
print(b)

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a ** 2)
print(a < b) 
print(a > b)
print(a.dot(b))  # Scalar: a[0]*b[0] + a[1]*b[1] + ... 

# aggregation functions 
a = np.arange(10)
print(a.sum()) # >>>45
print(a.min()) # >>>0
print(a.max()) # >>>9
print(a.cumsum()) # >>>[ 0  1  3  6 10 15 21 28 36 45]

# Fancy indexing
a = np.arange(0, 100, 10)
print(a) # >>>[ 0 10 20 30 40 50 60 70 80 90]
print(a[[True, False, True, True, True, False, True, True, True, False]]) # Boolean masking
print(a[1])
print(a[[1, 5, -1]]) # >>>[10 50 90]

# Boolean masking

# numpy.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
# 在指定的间隔内返回均匀间隔的数字。 返回num均匀分布的样本，在[start, stop]。
a = np.linspace(0, 2 * np.pi, 50)
b = np.sin(a)
plt.plot(a,b)
#plt.show()
mask = b >= 0  # Boolean masking
plt.plot(a[mask], b[mask], 'bo')
#plt.show()

'''
color：线条颜色，值r表示红色（red）
marker：点的形状，值o表示点为圆圈标记（circle marker）
linestyle：线条的形状，值dashed表示用虚线连接各点
plt.plot(x, y, color='r',marker='o',linestyle='dashed')
'''

mask = (b >= 0) & (a <= np.pi / 2) # Boolean masking
plt.plot(a[mask], b[mask], 'go')
#plt.show()

# Incomplete Indexing
a = np.arange(0, 100, 10)
b = a[:5]
c = a[a >= 50] # Boolean masking
print(b) # >>>[ 0 10 20 30 40]
print(c) # >>>[50 60 70 80 90]

# where function 
a = np.arange(0, 100, 10)
b = np.where(a < 50) 
c = np.where(a >= 50)[0]
print(b) # >>>(array([0, 1, 2, 3, 4]),)
print(c) # >>>[5 6 7 8 9]


