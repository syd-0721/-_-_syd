#第三章程序练习题3.4
"""
判断一个五位数是否是回文数
"""

n = input("请输入一个五位数：")
if len(n) != 5:
    print("输入的不是五位数")
else:
    if n[0] == n[4] and n[1] == n[3]:
        print("是回文数")
    else:
        print("不是回文数")