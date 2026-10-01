#第四章程序设计4.4

"""
利用随机数进行猜数字游戏
二分查找算法
"""

import random

target = random.randint(0, 1001)
guess = 0
i = 0
while guess != target:
    guess = int(input("请输入一个0到1000之间的数字: "))
    i += 1
    if guess < target:
        print("太小了")
    elif guess > target:
        print("太大了")
    else:
        print("恭喜你，猜对了！")
    print("你已经猜了{}次".format(i))

def thetory():
    left , right = 1 , 1000
    i = 1
    mid = (left + right) // 2
    while mid != target:
        if mid < target:
            left = mid + 1
        else:
            right = mid - 1
        mid = (left + right) // 2
        i += 1
    print("已知一个1到1000的预设整数，最少需要才{}次就能猜对".format(i))