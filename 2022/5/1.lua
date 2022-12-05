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

local function move(from, to)
  local f, t = stacks[from], stacks[to]
  t[#t+1] = f[#f]
  f[#f] = nil
end

for line in io.lines() do
  local count, from, to = line:match("move (%d+) from (%d+) to (%d+)")
  from, to = tonumber(from), tonumber(to)
  for _=1, tonumber(count) do
    move(from, to)
  end
end

for i=1, #stacks do
  io.write(stacks[i][#stacks[i]])
end
io.write("\n")
