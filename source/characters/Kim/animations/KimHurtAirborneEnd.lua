return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  name = "KimHurtAirborneEnd",
  class = "Animation",
  tilewidth = 128,
  tileheight = 80,
  spacing = 0,
  margin = 0,
  columns = 0,
  objectalignment = "unspecified",
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
  tilecount = 4,
  tiles = {
    {
      id = 0,
      type = "Frame",
      properties = {
        ["frameDuration"] = 2
      },
      image = "../images/KimHurtAirborneEnd1.gif",
      width = 128,
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
            x = 44,
            y = 18,
            width = 40,
            height = 42,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 2,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 64,
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
      id = 1,
      type = "Frame",
      properties = {
        ["frameDuration"] = 1
      },
      image = "../images/KimHurtAirborneEnd2.gif",
      width = 128,
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
            x = 44,
            y = 18,
            width = 40,
            height = 42,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 2,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 64,
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
        ["frameDuration"] = 1,
        ["velocityX"] = -1
      },
      image = "../images/KimHurtAirborneEnd3.gif",
      width = 128,
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
            id = 5,
            name = "Pushbox",
            type = "Pushbox",
            shape = "rectangle",
            x = 44,
            y = 18,
            width = 40,
            height = 42,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 4,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 64,
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
        ["frameDuration"] = 5,
        ["nextState"] = 32768
      },
      image = "../images/KimHurtAirborneEnd3.gif",
      width = 128,
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
            x = 44,
            y = 18,
            width = 40,
            height = 42,
            rotation = 0,
            visible = true,
            properties = {}
          },
          {
            id = 3,
            name = "Center",
            type = "Center",
            shape = "point",
            x = 64,
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
