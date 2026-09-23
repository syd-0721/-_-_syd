#第三章程序练习题3.2,3.3
"""
这是一道'天天向上’的题目，每周工作7天，前三天不进步，后四天每天进步1%。
10天休息一次
15天休息一次
"""

def dayly_progress():
    progress = 1
    progress_new = 1
    for j in range(1,53):
        for i in range(1,8):
            if i<=3 :
                progress_new = progress
            else :
                progress_new *= 1.01
            progress = progress_new
    print('每周工作7天，前三天不进步，后四天每天进步1%的进度是：', progress)

def dayly_progress_10rest():
    progress = 1
    progress_new = 1
    for j in range(1,37):
        for i in range(1,11):
            if i<=3 or i>=8 :
                progress_new = progress
            else :
                progress_new *= 1.01
            progress = progress_new
    progress = progress*1.01*1.01
    print(progress)

def dayly_progress_15rest():
    progress = 1
    progress_new = 1
    for j in range(1,25):
        for i in range(1,16):
            if i<=3 or 8<=i<=10 or i==15 :
                progress_new = progress
            else :
                progress_new *= 1.01
            progress = progress_new
    progress = progress*1.01*1.01
    print(progress)

dayly_progress()
dayly_progress_10rest()
dayly_progress_15rest()