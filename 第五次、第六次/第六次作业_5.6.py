#第五章程序练习题5.6

"""
不限参数个数，所有相乘，返回结果
"""

def multi(*args):
    result = 1
    for i in args:
        result *= i
    return result

multi(1, 2, 3, 4, 5)