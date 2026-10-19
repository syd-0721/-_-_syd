#第五章课上练习题

"""
温度转换，同时支持摄氏度和华氏度的转换。并且进行函数的包装
"""

def c_main():
    tem = input("请输入结尾带有f的华氏度：")
    if tem[-1] in ['f', 'F']:
        c = (float(tem[:-1]) - 32) * 5 / 9
        print("转换后的摄氏度为：{:.2f}°C".format(c))
    else:
        print("输入格式错误，请确保输入以'f'或'F'结尾。")

def f_main():
    tem = input("请输入结尾带有c的摄氏度：")
    if tem[-1] in ['c', 'C']:
        f = (float(tem[:-1]) * 9 / 5) + 32
        print("转换后的华氏度为：{:.2f}°F".format(f))
    else:
        print("输入格式错误，请确保输入以'c'或'C'结尾。")

c_main()
f_main()