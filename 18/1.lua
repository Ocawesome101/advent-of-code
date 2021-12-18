local lines = {}

for line in io.lines("18/t2") do
  local st = assert(load("return " .. 
    line:gsub("%[", "{"):gsub("%]", "}"), "=haha gsub"))()
  lines[#lines+1] = st
end

local function rp(t)
  if type(t) == "number" then return io.write(t) end
  io.write("[")
  rp(t[1])
  io.write(",")
  rp(t[2])
  io.write("]")
end

local function mkflat(i, d)
  if type(i) == "number" then
    return {{i, d}}
  end
  local r = {}
  for k, v in pairs(i) do
    local add = mkflat(v, d + 1)
    for i=1, #add, 1 do
      r[#r+1] = add[i]
    end
  end
  return r
end

local function toflat(line)
  local flat = {}
  for k,v in pairs(line) do
    local items = mkflat(v, 1)
    for i=1, #items, 1 do
      flat[#flat+1] = items[i]
    end
  end
  return flat
end

local function split(flat)
  local i = 0
  while i < #flat do
    i = i + 1
    local it = flat[i]
    if it[1] > 9 then
      local a, b = it[1] // 2, math.ceil(it[1] / 2)
      flat[i] = {a, it[2] + 1}
      table.insert(flat, i + 1, {b, it[2] + 1})
    end
  end
end

local function parse(flat)
  repeat
    print("STEP")
    split(flat)
    for i=1, #flat, 1 do
      print(table.unpack(flat[i]))
    end
    local found = false
    for i, num in ipairs(flat) do
      if num[2] > 4 then
        if flat[i+1][2] == num[2] then
          local a, b = num[1], table.remove(flat, i+1)[1]
          num[1] = 0
          num[2] = num[2] - 1
          if flat[i-1] then flat[i-1][1] = flat[i-1][1] + a end
          if flat[i+1] then flat[i+1][1] = flat[i+1][1] + b end
          found = true
          break
        end
      end
    end
  until not found

  return flat
end

local function fromflat(flat)
  local struct = ""
  local nu = {0}
  for i, num in ipairs(flat) do
    local num, depth = num[1], num[2]
    if nu[#nu] == 2 then
      struct = struct .. "},"
      nu[#nu] = 0
    end
    if i == 1 then
      struct = struct .. "{"
    elseif depth > flat[i - 1][2] then
      struct = struct .. "{"
      for i=1, depth - flat[i - 1][2], 1 do
        struct = struct .. "{"
        nu[#nu+1] = 0
      end
    elseif depth < flat[i - 1][2] then
      for i=1, flat[i - 1][2] - depth, 1 do
        struct = struct .. "},"
        nu[#nu] = nil
      end
    end
    nu[#nu] = (nu[#nu] or 0) + 1
    struct = struct .. num .. ","
  end
  struct = struct .. string.rep("}", flat[#flat][2])
  print(struct)
  return assert(load("return " .. struct, "=TIHI"))()
end

local function magnitude(pair)
  if type(pair) == "number" then return pair end
  return magnitude(pair[1]) * 3 + magnitude(pair[2]) * 2
end

local total
for i=1, #lines, 1 do
  if total then
    total = {total, lines[i]}
  else
    total = lines[i]
  end
end

total = fromflat(parse(toflat(total)))

rp(total)
print""

print(magnitude(total))
