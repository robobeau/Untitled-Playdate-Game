-- Tiled's custom properties need to be converted into a table.
function ConvertCustomPropertiesToTable(customProperties)
  local properties <const> = {}

  for _, customProperty in ipairs(customProperties) do
    properties[customProperty.name] = customProperty.value
  end

  return properties
end