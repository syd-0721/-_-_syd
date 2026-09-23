#二次函数，考虑虚根

"""
二次方程的两个根
"""
from cmath import sqrt

a = int(input('请输入a'))
b = int(input('请输入b'))
c = int(input('请输入c'))
delta1 = pow(b,2) - 4*a*c
delta = complex(sqrt(delta1))

answer1 = (-b+delta)/2*a
answer2 = (-b-delta)/2*a

print(answer1)
print(answer2)