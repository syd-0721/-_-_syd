#3_2号作业（第二次作业）

"""
因为没有学习循环结构，所以 第三第四题 没有办法使用循环来实现，所以只能使用重复的代码来实现
"""

a = input("请输入一个4位数")
print("千位数值为{}百位数值为{}十位数值为{}个位数值为{}".format(a[0],a[1],a[2],a[3]))

b = input("输入你的身份证号")
print("{}年{}月{}日".format(b[6:10],b[10:12],b[12:14]))

c = input("请输入一个字符")
print("  {}".format(c))
print(" {} {}".format(c, c))
print("{}   {}".format(c, c))
print(" {} {}".format(c, c))
print("  {}".format(c, c))

d = c
print("  {}".format(d))
print(" {}{}{}".format(c,c,c))
print("{}{}{}{}{}".format(c,c,c,c,c))
print(" {}{}{}".format(c,c,c))
print("  {}".format(c))

f = "+----+----+"
g = "|    |    |"
for i in range (1,12):
    if i==1 or i==6 or i==11:
        print(f)
    else:
        print(g)