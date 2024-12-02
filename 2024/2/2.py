
import sys

def sign(n):
    if n==0:
        return 0
    return n/abs(n)

def isSafe(report):
    bs = sign(report[1] - report[0])
    for i in range(1, len(report)):
        last, cur = report[i-1], report[i]
        dif = cur-last
        if sign(dif) != bs or dif == 0 or abs(dif) > 3:
            return False
    return True

safe = 0
for line in sys.stdin.readlines():
    report = [int(n) for n in line.strip().split(" ")]
    if isSafe(report):
        safe += 1
    else:
        for i in range(0, len(report)):
            copy = report.copy()
            copy.pop(i)
            if isSafe(copy):
                safe += 1
                break
print(safe)
