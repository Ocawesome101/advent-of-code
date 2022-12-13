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

local function compare(a, b)
  if not a then return true end
  if not b then return false end

  print("compare " .. #a .. vis(a) .. " to " .. #b.. vis(b))

  for i=1, math.max(#a, #b) do
    local ai, bi = a[i], b[i]
    if not ai then return true end
    if not bi then return false end

    if type(ai) == "number" and type(bi) == "number" then
      print("compare " .. ai .. " to " .. bi)
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

local o = 0
local i = 0
for p1, p2 in io.lines(nil, "l", "l") do
  i = i + 1
  print("== pair " .. i .. " ==")
  p1, p2 = parse(p1), parse(p2)
  local r = compare(p1, p2)
  assert(r ~="ambiguous")
  if r then print(i) o = o + i end
  io.read()
end

print(o)
