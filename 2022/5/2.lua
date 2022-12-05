local stacks = {}

local raw_stacks = {}

repeat
  local line = io.read("l")
  if line:find("%[") then
    raw_stacks[#raw_stacks + 1] = line
  elseif line ~= "" then
    local num = tonumber(line:match("(%d) $"))
    for i=1, num do
      stacks[i] = {}
    end
  end
until line == ""

for i=#raw_stacks, 1, -1 do
  local line = raw_stacks[i]
  local c = 0
  for stack in line:gmatch("(...) ?") do
    c = c + 1
    if stack:sub(1,1) == "[" then
      stacks[c][#stacks[c]+1] = stack:sub(2,2)
    end
  end
end

local function move(count, from, to)
  local f, t = stacks[from], stacks[to]
  local m = {}
  local nf = #f
  for i=1, count do
    m[#m+1] = f[nf-(i-1)]
    f[nf-(i-1)] = nil
  end
  for i=#m, 1, -1 do
    t[#t+1] = m[i]
  end
end

for line in io.lines() do
  local count, from, to = line:match("move (%d+) from (%d+) to (%d+)")
  move(tonumber(count), tonumber(from), tonumber(to))
end

for i=1, #stacks do
  io.write(stacks[i][#stacks[i]])
end
io.write("\n")
