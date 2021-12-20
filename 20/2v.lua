local enhance = {}

local invt = false
local rowmt = {
  __index = function(t, k) t[k] = invt and "#" or "."; return t[k] end
}

local imgmt = {
  __index = function(t, k)
    t[k] = setmetatable({}, rowmt)
    return t[k]
  end
}

local image = setmetatable({}, imgmt)

for line in io.lines("20/i") do
  if #enhance == 0 then
    for c in line:gmatch(".") do enhance[#enhance+1] = c == "#" end
  elseif #line > 0 then
    local n = #image + 1
    local row = setmetatable({}, rowmt)
    for c in line:gmatch(".") do
      row[#row+1] = c
    end
    image[n] = row
  end
end

for i=1, 50, 1 do
  local new = setmetatable({}, imgmt)
  
  local width = #image[1]
  for r = 0, #image + 1, 1 do
    new[r + 1] = setmetatable({}, rowmt)
    for c = 0, width + 1, 1 do
      local bin = ""
      for _r = r-1, r+1, 1 do
        for _c = c-1, c+1, 1 do
          bin = bin .. image[_r][_c]
        end
      end
      bin = tonumber(bin:gsub("%.", "0"):gsub("#", "1"), 2)
      new[r + 1][c + 1] = enhance[bin + 1] and "#" or "."
    end
  end

  image = new
  invt = enhance[1] and not invt
  local fb = io.open("/tmp/frame"..string.format("%02d", i)..".rgb", "w")
  local out = {}
  local scale = 5
  for r=1, #image, 1 do
    local ln = ""
    local row = image[r]
    for c=1, #image[1], 1 do
      ln = ln .. (row[c] == "#" and "\255\255\255" or "\0\0\0"):rep(scale)
    end
    for s=1, scale do
      out[#out+1] = ln
    end
  end
  for i=1, 1080, 1 do
    fb:seek("set", 1920 * (i - 1) * 3)
    fb:write(out[i] or "", ("\0"):rep(1920 * 3 - #(out[i] or "")))
  end
  fb:close()
end
