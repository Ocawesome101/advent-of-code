
import sys

puzzle = [[c for c in line] for line in sys.stdin.readlines()]

total = 0

def get(x, y):
    if y < 0 or y >= len(puzzle):
        return ''
    if x < 0 or x >= len(puzzle[y]):
        return ''
    return puzzle[y][x]

def search(x, y):
    if get(x,y) == "A":
        corners = get(x-1,y-1) + get(x+1,y-1) + get(x+1,y+1) + get(x-1,y+1)
        if corners == "MMSS" or corners == "SMMS" or corners == "SSMM" or corners == "MSSM":
            return 1
    return 0


for y in range(0, len(puzzle)):
    for x in range(0, len(puzzle[y])):
        total += search(x, y)

print(total)
