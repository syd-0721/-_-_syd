ptxt = input("请输入一段明文: ")
for i in ptxt :
    if i.islower():
        print(chr((ord(i) - 97 + 3) % 26 + 97), end="")
    else:
        print(chr((ord(i) - 65 + 3) % 26 + 65), end="")