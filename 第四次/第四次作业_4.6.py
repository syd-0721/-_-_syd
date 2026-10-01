# 第四章程序设计4.6
"""
判断一个年份是否为闰年
"""

year = int(input("请输入一个年份: "))

if year % 4 == 0 and year % 100 != 0 or year % 400 == 0:
    print("{}年是闰年".format(year))
else:
    print("{}年不是闰年".format(year))