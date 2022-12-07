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

local total = 0

local function findSize(dir)
  local size = 0
  for _, info in pairs(dir.files) do
    if info.dir then
      size = size + findSize(info)
    else
      size = size + info.size
    end
  end

  if size <= 100000 then
    total = total + size
  end

  return size
end

findSize(tree)

print(total)
