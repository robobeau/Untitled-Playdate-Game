function ConvertCollisionsArrayToTable(collisions)
  local collisionsTable <const> = {
    Hitboxes = {},
    Hurtboxes = {},
    Pushbox = nil,
  }

  for i, collision in ipairs(collisions) do
    collision.properties = ConvertCustomPropertiesToTable(collision.properties or {})

    if (collision.class == 'Pushbox') then
      collisionsTable['Pushbox'] = collision
    end

    if (collision.class == 'Hitbox') then
      table.insert(collisionsTable['Hitboxes'], collision)
    end

    if (collision.class == 'Hurtbox') then
      table.insert(collisionsTable['Hurtboxes'], collision)
    end
  end

  return collisionsTable;
end

-- Tiled's custom properties need to be normalized into a table.
function ConvertCustomPropertiesToTable(customProperties)
  local propertiesTable <const> = {}

  for _, customProperty in ipairs(customProperties) do
    propertiesTable[customProperty.name] = customProperty.value
  end

  return propertiesTable;
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