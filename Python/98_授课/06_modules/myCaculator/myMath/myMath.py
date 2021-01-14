#!C:\Python\Python

__all__ = 'fib', 'fib2'

def fib(n):
    a, b = 0, 1
    while a < n:
        print(a, end=' ')
        a, b = b, a+b

def fib2(n):
    result = []
    a, b = 0, 1
    while a < n:
        result.append(a)
        a, b = b, a+b
    return result

if __name__ == "__main__":
    import sys
    print(__name__)
    fib(int(sys.argv[1]))
else:
    print(__name__)

