-- Tiled's custom properties need to be normalized into a table.
function ConvertCustomPropertiesToTable(customProperties)
  local table <const> = {}

  for _, customProperty in ipairs(customProperties) do
    table[customProperty.name] = customProperty.value
  end

  return table;
end

function Sign(number)
  if number > 0 then
    return 1
  elseif number < 0 then
    return -1
  else
    return 0
  end
end