# encoding: utf-8

import numpy as np
from numpy import ndarray

def test():
	a = ndarray((5,), int)
	print(a)
	b = np.empty(5, dtype=int)
	print(b)
	c = np.zeros((5,), dtype=int)
	print(c)
	print(c.dtype)

if __name__ == '__main__':
	test()