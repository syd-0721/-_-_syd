import time
scale = 10
d = "Starting"
for i in range(scale+1):
    a,b = '.' * i, '.' * (scale - i)
    c = (i/scale) * 100
    print("\r{} {:>3.0f} [{}->{}] {}".format(d, c, a, b,"Done!"), end='')
    time.sleep(0.1)
#print("{} {}->{} {}".format(d , '*' * scale, '.' * 0, "Done!"))