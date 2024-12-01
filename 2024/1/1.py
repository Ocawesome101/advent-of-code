
import sys

lists = [[],[]]

for line in sys.stdin.readlines():
  nums = line.strip().split("   ")
  lists[0].append(int(nums[0]))
  lists[1].append(int(nums[1]))

lists[0].sort()
lists[1].sort()

dist = 0
for i in range(0, len(lists[0])):
    dist += abs(lists[0][i]-lists[1][i])

print(dist)
