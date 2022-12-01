-- this would take about 576,000 years to execute
-- i don't think i'll live that long
local universes = {
  -- p1, p2, s1, s2
  {5, 8, 0, 0}
}

local wonp1, wonp2 = 0, 0

while #universes > 0 do
  for i=#universes, 1, -1 do
    print(#universes)
    local p1, p2, s1, s2 = table.unpack(universes[i])
    if s1 < 21 and s2 < 21 then
      for ap1=3, 9, 1 do
        for ap2=3, 9, 1 do
          local np1 = p1 + ap1
          local np2 = p2 + ap2
          local ns1 = s1 + ap1
          local ns2 = s1
          if ns2 < 21 then
            ns2 = s2 + ap2
          end
          universes[#universes+1] = {np1, np2, ns1, ns2}
        end
      end
    else
      if s1 >= 21 then wonp1 = wonp1 + 1 end
      if s2 >= 21 then wonp2 = wonp2 + 1 end
      table.remove(universes, i)
    end
  end
end
