
import sys

lists = [[],{}]

for line in sys.stdin.readlines():
  nums = line.strip().split("   ")
  lists[0].append(int(nums[0]))
  n1 = int(nums[1])
  if not lists[1].get(n1):
      lists[1][n1] = 0
  lists[1][n1] += 1

sim = 0

for i in range(0, len(lists[0])):
    if lists[1].get(lists[0][i]):
        sim += lists[0][i]*lists[1][lists[0][i]]

print(lists[0], lists[1])
print(sim)
