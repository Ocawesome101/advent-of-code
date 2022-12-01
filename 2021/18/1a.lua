local function eval(num)
  local line = {}
  do
  
    local i = 0
    while #num > 0 do
      i = i + 1
      local c
      c, num = num:sub(1,1), num:sub(2)
      if c:match("%d") then
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
          return true -- i = 0
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

  repeat
    local e = explode() or split()
    --print((table.concat(line):gsub("%]%[","],["):gsub("(%d)(%d)","%1,%2")))
  until not e
  
  return table.concat(line)
    :gsub("%]%[", "],[")
    :gsub("(%d)(%d)", "%1,%2")
    :gsub("%](%d)", "],%1")
    :gsub("(%d)%[", "%1,[")
end

local num = ""
for line in io.lines("18/i") do
  if #num > 0 then
    num = eval("[" .. num .. "," .. eval(line) .. "]")
  else
    num = eval(line)
  end
end

local function magnitude(pair)
  if type(pair) == "number" then return pair end
  return magnitude(pair[1]) * 3 + magnitude(pair[2]) * 2
end

local rep = {["["] = "{", ["]"] = "}"}
print(num)
print(magnitude(assert(load("return " .. num:gsub("[%[%]]", rep), "=tihi"))()))
