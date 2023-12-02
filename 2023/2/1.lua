local function splitgame(g)
  local s1 = {}
  for draw in g:gmatch("[^;]+") do
    s1[#s1+1] = draw
  end
  local draws = {}
  for i=1, #s1 do
    local d = {red=0,green=0,blue=0}
    draws[#draws+1] = d
    for amt, color in s1[i]:gmatch("(%d+) ([a-z]+)") do
      d[color] = tonumber(amt)
    end
  end
  return draws
end

local r, g, b = 12, 13, 14

local sum = 0

for line in io.lines() do
  local id, poss = line:match("Game (%d+): (.+)")
  local game = splitgame(poss)
  local valid = true
  for i=1, #game do
    if game[i].red > r or game[i].green > g or game[i].blue > b then
      valid = false
      break
    end
  end
  if valid then sum = sum + tonumber(id) end
end

print(sum)
