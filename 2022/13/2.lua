local function parse(l)
  return load("return " .. l:gsub("%[", "{"):gsub("%]", "}"))()
end

local function vis(t)
  local w = {}
  for i=1, #t do
    if type(t[i]) == "table" then
      w[i] = vis(t[i])
    else
      w[i] = t[i]
    end
  end
  return "[" .. table.concat(w, ",") .. "]"
end

local packets = {}

local function compare(a, b)
  if not a then return true end
  if not b then return false end

--  print("compare " .. #a .. vis(a) .. " to " .. #b.. vis(b))

  for i=1, math.max(#a, #b) do
    local ai, bi = a[i], b[i]
    if not ai then return true end
    if not bi then return false end

    if type(ai) == "number" and type(bi) == "number" then
--      print("compare " .. ai .. " to " .. bi)
      if ai > bi then return false end
      if ai < bi then return true end
    else
      if type(ai) == "number" then
        ai = {ai}
      elseif type(bi) == "number" then
        bi = {bi}
      end
      local r = compare(ai, bi)
      if r ~= "ambiguous" then return r end
    end
  end

  return "ambiguous"
end

local d1, d2 = {{2}}, {{6}}
packets[#packets+1] = d1
packets[#packets+1] = d2

for packet in io.lines() do
  if #packet > 0 then packets[#packets+1] = parse(packet) end
end

print(#packets)

table.sort(packets, function(a,b)
  local r = compare(a,b)
  if r == "ambiguous" then return false end
  return not not r
end)

local d1i, d2i = 0, 0
for i=1, #packets do
  if packets[i] == d1 then
    d1i = i --#packets - i + 1
  elseif packets[i] == d2 then
    d2i = i --#packets - i + 1
  end
end

print(d1i, d2i, d1i*d2i)
