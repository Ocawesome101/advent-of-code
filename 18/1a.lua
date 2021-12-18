local num = ""

for line in io.lines("18/t3") do
  if #num > 0 then
    num = "[" .. num .. "," .. line .. "]"
  else
    num = line
  end
end

local line = {}
do

  local i = 0
  while #num > 0 do
    i = i + 1
    local c
    c, num = num:sub(1,1), num:sub(2)
    if c:match("%d") then
      if num:sub(1,1):match("%d") then
        c = c .. num:sub(1,1)
        num = num:sub(2)
      end
      line[#line+1] = tonumber(c)
    elseif c ~= "," then -- commas are implicit
      line[#line+1] = c
    end
  end

end

local function split()
  local i = 1
  while i < #line do
    local c = line[i]
    if type(c) == "number" then
      if c > 9 then
        local a, b = math.floor(c / 2), math.ceil(c / 2)
        -- remove original number and insert [ A B ]
        table.remove(line, i)
        table.insert(line, i, "]")
        table.insert(line, i, b)
        table.insert(line, i, a)
        table.insert(line, i, "[")
        return -- i = 0
      end
    end
    i = i + 1
  end
end

local function explode()
  local depth = 0

  for i=1, #line, 1 do
    local c = line[i]
    if c == "[" then
      depth = depth + 1
    elseif c == "]" then
      depth = depth - 1
    else
      if depth > 4 and type(line[i+1]) == "number" then
        -- explody time
        -- find the nearest number before and after this one
        local prev, nxtinpair, nxt
        for i=i-1, 1, -1 do
          if type(line[i]) == "number" then
            prev = i
            break
          end
        end
        for i=i+1, #line, 1 do
          if type(line[i]) == "number" then
            if nxtinpair then
              nxt = i
              break
            else
              nxtinpair = i
            end
          end
        end
        print(prev, nxtinpair, nxt)
        if prev then line[prev] = line[prev] + c end
        if nxt then line[nxt] = line[nxt] + line[nxtinpair] end
        -- remove the [ N N ] from the line
        table.remove(line, i - 1)
        table.remove(line, i - 1)
        table.remove(line, i - 1)
        table.remove(line, i - 1)
        table.insert(line, i - 1, 0)
        return true
      end
    end
  end

  return
end

print(table.concat(line))
repeat
  split()
  print((table.concat(line):gsub("%]%[","],["):gsub("(%d)(%d)","%1,%2")))
until not explode()

local function magnitude(pair)
  if type(pair) == "number" then return pair end
  return magnitude(pair[1]) * 3 + magnitude(pair[2]) * 2
end

print(magnitude(assert(load
--print
  ("return " .. table.concat(line)
    :gsub("%]%[", "],[")
    :gsub("(%d)(%d)", "%1,%2")
    :gsub("%]", "}")
    :gsub("%[", "{")
    :gsub("}(%d)", "},%1")
    :gsub("(%d){", "%1,{"), "=tihi"))()))
