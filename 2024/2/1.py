
import sys

def gsign(n):
    if n==0:
        return 1
    return n/abs(n)

safe = 0
for line in sys.stdin.readlines():
    report = [int(n) for n in line.strip().split(" ")]
    sign = gsign(report[1] - report[0])
    safe += 1
    for i in range(1, len(report)):
        cur, last = report[i], report[i-1]
        if gsign(cur - last) != sign or abs(cur - last) == 0 or abs(cur - last) > 3:
            safe -= 1
            break
print(safe)
