#2.18同心圆小乌龟
"""
import turtle as t
a = random.randint(1,10)
    # a = int(input("请输入任意一个非负非零整数"))
for i in range(a,a+10):
    true_i = 10*i
    t.circle(true_i)
    t.penup()
    t.seth(-90)
    t.fd(10*a)
    t.seth(0)
    t.pendown()
"""

