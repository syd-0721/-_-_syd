#第三章程序练习题3.5

"""
打印一个5x5的网格
"""

f = "+----+----+"
g = "|    |    |"
for i in range (1,12):
    if i==1 or i==6 or i==11:
        print(f)
    else:
        print(g)