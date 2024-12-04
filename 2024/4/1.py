
import sys

puzzle = [[c for c in line] for line in sys.stdin.readlines()]

total = 0

def searchXY(x, y, xo, yo):
    c = ['M', 'A', 'S']
    for i in range(1, 4):
        sx, sy = x+xo*i, y+yo*i
        if sx >= 0 and sy >= 0 and sy < len(puzzle):
            if sx < len(puzzle[sy]):
                if puzzle[sy][sx] != c[i-1]:
                    return 0
            else:
                return 0
        else:
            return 0
    return 1

def search(x, y):
    if puzzle[y][x] == "X":
        return searchXY(x, y, 1, 0) + \
            searchXY(x, y, -1, 0) + \
            searchXY(x, y, 0, 1) + \
            searchXY(x, y, 0, -1) + \
            searchXY(x, y, 1, 1) + \
            searchXY(x, y, 1, -1) + \
            searchXY(x, y, -1, 1) + \
            searchXY(x, y, -1, -1)
    return 0

for y in range(0, len(puzzle)):
    for x in range(0, len(puzzle[y])):
        total += search(x, y)

print(total)
