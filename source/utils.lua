-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
-- local gfx <const> = pd.graphics

-- Tiled's custom properties need to be converted into a table.
function ConvertCustomPropertiesToTable(customProperties)
  local properties <const> = {}

  for _, customProperty in ipairs(customProperties) do
    properties[customProperty.name] = customProperty.value
  end

  return properties;
end

function ExtractCharacterObjects(objects)
  local center = nil
  local collisions <const> = {
    Hitboxes = {},
    Hurtboxes = {},
    Pushbox = nil,
  }

  for i, object in ipairs(objects) do
    local properties <const> = ConvertCustomPropertiesToTable(object.properties or {})

    if (object.type == 'Center') then
      center = geo.point.new(object.x, object.y)
    end

    if (object.type == 'Pushbox') then
      local rect <const> = geo.rect.new(object.x, object.y, object.width, object.height)

      collisions['Pushbox'] = {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rect,
        type = object.type,
      }
    end

    if (object.type == 'Hitbox') then
      local rect <const> = geo.rect.new(object.x, object.y, object.width, object.height)

      table.insert(collisions['Hitboxes'], {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rect,
        type = object.type,
      })
    end

    if (object.type == 'Hurtbox') then
      local rect <const> = geo.rect.new(object.x, object.y, object.width, object.height)

      table.insert(collisions['Hurtboxes'], {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rect,
        type = object.type,
      })
    end
  end

  return center, collisions;
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