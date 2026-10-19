#第五章程序练习题5.1

"""
实现字符田字格绘制
"""

def draw_grid(width):
    i = 1
    while i < 5:
        for j in range(1,5):
            print("+","-" * width)

#半成品，未完成