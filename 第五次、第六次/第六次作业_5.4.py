##第五章程序练习题5.3

"""
打印一列在指定范围内的质数，并将判断质数这个功能使用函数包装
"""

def isPrime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def PrimeList(n):
    for i in range(2, n + 1):
        if isPrime(i):
            print(i, end=' ')
    print()

PrimeList(9)