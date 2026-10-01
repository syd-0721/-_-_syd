#第四章程序设计4.5

"""
在4.4的基础上，加上判断是否为小数
"""

import random

target = random.randint(0, 1001)
guess = 0
i = 0
while guess != target:
    guess = input("请输入一个0到1000之间的数字: ")
    if "." in guess:
        print("请输入一个整数")
        continue
    guess = int(guess)
    i += 1
    if guess < target:
        print("太小了")
    elif guess > target:
        print("太大了")
    else:
        print("恭喜你，猜对了！")
    print("你已经猜了{}次".format(i))
