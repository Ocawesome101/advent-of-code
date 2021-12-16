# so python has this handy pathfinding module
# so i solved day 15 in python

from numpy import ndarray
from skimage.graph import route_through_array

grid = ndarray(shape=(100, 100), dtype=int)
row, col = 0, 0
for line in open("15/i"):
    col = 0
    for char in line:
        if char != '\n':
            grid.itemset((row, col), int(char))
            col += 1
    row += 1

path, cost = route_through_array(grid, (0, 0), (99, 99), fully_connected=False)
print(cost)
