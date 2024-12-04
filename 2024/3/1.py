
import sys, re

data = sys.stdin.read().strip()

print(
    sum(
        [int(a)*int(b) for (a,b) in re.findall(r'mul\((\d+),(\d+)\)', data)]
        )
    )
