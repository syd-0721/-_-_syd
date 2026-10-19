#第五章程序练习题5.2

"""
实现判断一个数是否为奇数，数不限类型，但使用try except语句处理异常
"""

def isOdd(num):
    try:
        if num % 2 == 1:
            return True
        else:
            return False
    except TypeError:
        return False

isOdd(input("请输入一个数："))