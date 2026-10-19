#第五章程序练习题5.3

"""
判断一个数是否为质数，类型不限，但使用try except语句处理异常
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

print(isPrime(eval(input("请输入一个数："))))
