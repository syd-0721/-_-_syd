#第五章程序练习题5.3

"""
参数是输入一个字符串，并判断是否为整数，浮点数，复数，返回True，否则返回False；另外使用try except语句处理异常
"""

def isNum(str_a):
    try:
        float(str_a)
        int(str_a)
        complex(str_a)
        return True
    except ValueError:
        return False

print(isNum(input("请输入一个数：")))