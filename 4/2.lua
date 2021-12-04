local order = {}

local line = io.read("l")
for n in line:gmatch("[^,]+") do
  order[#order+1] = tonumber(n)
end

local boards = {}

for line in io.lines() do
  if line == "" then
    boards[#boards+1] = {}
  else
    local board = boards[#boards]
    local numbers = {}
    for n in line:gmatch("[^ ]+") do
      numbers[#numbers+1] = {n = tonumber(n), s = false}
    end
    board[#board+1] = numbers
  end
end

local function checkRow(b, i)
  for i, num in ipairs(b[i]) do
    if not num.s then return false end
  end
  return true
end

local function checkColumn(b, i)
  for r=1, 5, 1 do
    local num = b[r][i]
    if not num.s then return false end
  end
  return true
end

local function checkBoard(b)
  for i=1, 5, 1 do
    if checkRow(b, i) then return true end
    if checkColumn(b, i) then return true end
  end
end

local function checkBoards()
  local n
  for i, b in ipairs(boards) do
    if not b.won then
      if checkBoard(b) then n = i; b.won = true end
    end
  end
  return n
end

local won, last = 0, 0
for i, num in ipairs(order) do
  for B, b in ipairs(boards) do
    if not b.won then
      last = num
      for R, row in ipairs(b) do
        for C, col in ipairs(row) do
          if col.n == num then col.s = true end
        end
      end
    end
  end

  local idx = checkBoards()
  if idx then
    won = idx
  end
end

local unmarked = 0
for _, row in ipairs(boards[won]) do
  for _, col in ipairs(row) do
    if not col.s then unmarked = unmarked + col.n end
  end
end

print(unmarked * last)
