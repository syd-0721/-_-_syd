# 第四章程序设计4.7

"""
利用异常处理机制进行验证用户输入的内容是否为十进制整数
"""

a = input("请输入一个十进制整数: ")
try:
    a = int(a)
    print("输入的十进制整数是: {}".format(a))
except ValueError:
    print("输入的不是有效的十进制整数")