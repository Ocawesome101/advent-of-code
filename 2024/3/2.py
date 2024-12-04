
import sys, re

data = sys.stdin.read().strip()
do = True
total = 0
           
for v in re.findall(r"""mul\((\d+),(\d+)\)|(do)\(\)|(don't)\(\)""", data):
    if v[0] and do:
        total += int(v[0])*int(v[1])
    elif v[2]:
        do = True
    else:
        do = False

print(total)

#print(re.findall(r'mul\((\d+),(\d+)\)', data))
#for mul in re.findall(r'mul\((\d+),(\d+)\)', data):
    
