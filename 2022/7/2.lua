-- name = { dir = true, files = { name = { dir = false, size = 1304 } },
--          parent = {...} }
local tree = { dir = true, files = {}, parent = nil }

-- parse input
local pwd = tree

for line in io.lines() do
  if line:sub(1,1) == "$" then
    local cmd = line:sub(3,4)

    if cmd == "cd" then
      local dir = line:sub(6)
      if dir == "/" then
        pwd = tree
      elseif dir == ".." then
        pwd = pwd.parent
      else
        pwd = pwd.files[dir]
      end
    end

  else
    local tos, name = line:match("([^ ]+) ([^ ]+)")
    if tos == "dir" then
      pwd.files[name] = { dir = true, files = {}, parent = pwd }
    else
      local size = tonumber(tos)
      pwd.files[name] = { dir = false, size = size }
    end
  end
end

local total = 70000000
local needed = 30000000
local minimum = needed - total
local smallest = 112323423134231

local function findSize(dir, filter)
  local size = 0
  for _, info in pairs(dir.files) do
    if info.dir then
      size = size + findSize(info, filter)
    else
      size = size + info.size
    end
  end

  if filter then
    if size > minimum and size < smallest then smallest = size end
  end

  return size
end

local used = findSize(tree, false)
minimum = needed - (total - used)

findSize(tree, true)

print(smallest)
