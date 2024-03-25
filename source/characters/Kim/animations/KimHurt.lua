return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  name = "KimHurt",
  class = "Animation",
  tilewidth = 112,
  tileheight = 80,
  spacing = 0,
  margin = 0,
  columns = 0,
  objectalignment = "bottom",
  tilerendersize = "tile",
  fillmode = "stretch",
  tileoffset = {
    x = 0,
    y = 0
  },
  grid = {
    orientation = "orthogonal",
    width = 1,
    height = 1
  },
  properties = {},
  wangsets = {},
  tilecount = 3,
  tiles = {
    {
      id = 0,
      type = "Frame",
      properties = {
        ["duration"] = 2
      },
      image = "../images/KimHurt1.gif",
      width = 112,
      height = 80,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        class = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 2,
            name = "Pushbox",
            type = "Pushbox",
            shape = "rectangle",
            x = 34,
            y = -4,
            width = 40,
            height = 84,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 3,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 54,
            y = 80,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 2,
      type = "Frame",
      properties = {
        ["duration"] = 1,
        ["hitstunnable"] = true
      },
      image = "../images/KimHurt2.gif",
      width = 112,
      height = 80,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        class = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 2,
            name = "Pushbox",
            type = "Pushbox",
            shape = "rectangle",
            x = 56,
            y = -4,
            width = 40,
            height = 84,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 4,
            name = "Hurtbox (Low)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 50,
            y = 60,
            width = 54,
            height = 20,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 2
            }
          },
          {
            id = 5,
            name = "Hurtbox (Mid)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 40,
            y = 10,
            width = 52,
            height = 50,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 4
            }
          },
          {
            id = 6,
            name = "Hurtbox (High)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 8,
            y = 14,
            width = 36,
            height = 42,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 1
            }
          },
          {
            id = 3,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 76,
            y = 80,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    },
    {
      id = 3,
      type = "Frame",
      properties = {
        ["duration"] = 2,
        ["nextState"] = 4194304,
        ["velocityX"] = 0
      },
      image = "../images/KimHurt1.gif",
      width = 112,
      height = 80,
      objectGroup = {
        type = "objectgroup",
        draworder = "index",
        id = 2,
        name = "",
        class = "",
        visible = true,
        opacity = 1,
        offsetx = 0,
        offsety = 0,
        parallaxx = 1,
        parallaxy = 1,
        properties = {},
        objects = {
          {
            id = 3,
            name = "Pushbox",
            type = "Pushbox",
            shape = "rectangle",
            x = 34,
            y = -4,
            width = 40,
            height = 84,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 7,
            name = "Hurtbox (Low)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 24,
            y = 66,
            width = 58,
            height = 14,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 2
            }
          },
          {
            id = 5,
            name = "Hurtbox (Mid)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 26,
            y = 26,
            width = 44,
            height = 40,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 4
            }
          },
          {
            id = 6,
            name = "Hurtbox (High)",
            type = "Hurtbox",
            shape = "rectangle",
            x = 40,
            y = 8,
            width = 40,
            height = 36,
            rotation = 0,
            visible = true,
            properties = {
              ["type"] = 1
            }
          },
          {
            id = 4,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 54,
            y = 80,
            width = 0,
            height = 0,
            rotation = 0,
            visible = true,
            properties = {}
          }
        }
      }
    }
  }
}
