local dumbos = {}

for line in io.lines("11/i") do
  local row = {}
  for c in line:gmatch(".") do
    row[#row+1] = tonumber(c)
  end
  dumbos[#dumbos+1] = row
end

local flashes = 0
local function step(r, c, visited)
  visited = visited or {}
  visited[r] = visited[r] or {}
  if visited[r][c] then return end
  if dumbos[r][c] > 9 then
    visited[r][c] = true
    flashes = flashes + 1
    dumbos[r][c] = 0
    for _r=r-1, r+1, 1 do
      for _c=c-1, c+1, 1 do
        if _r ~= r or _c ~= c then
          if dumbos[_r] and dumbos[_r][_c] and not (visited[_r] and visited[_r][_c]) then
            dumbos[_r][_c] = dumbos[_r][_c] + 1
            step(_r, _c, visited)
          end
        end
      end
    end
  end
end

local replacements = {
  ["0"] = "\27[91m0",
  ["1"] = "\27[90m1",
  ["2"] = "\27[90m2",
  ["3"] = "\27[90m3",
  ["4"] = "\27[90m4",
  ["5"] = "\27[90m5",
  ["6"] = "\27[90m6",
  ["7"] = "\27[90m7",
  ["8"] = "\27[90m8",
  ["9"] = "\27[90m9",
}

local i = 0
while true do
  flashes = 0
  i = i + 1
  for r, row in ipairs(dumbos) do
    for c, item in ipairs(row) do
      row[c] = item + 1
    end
  end
  local v = {}
  for r, row in ipairs(dumbos) do
    for c, item in ipairs(row) do
      step(r, c, v)
    end
  end
  if flashes == 100 then print(i) break end
end
