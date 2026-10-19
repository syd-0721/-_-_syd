#第五章程序练习题5.7

"""
斐波那契数列求和，使用递归的方法
"""

def FabN(n):
    try:
        if n == 1 or n == 2:
            return 1
        else :
            return FabN(n-1) + FabN(n-2)
    except TypeError:
        return "输入类型错误，请输入整数。"

print(FabN(eval(input())))

