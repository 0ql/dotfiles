local wibox = require("wibox")
local gears = require("gears")

local sys = {}

local function txtbox()
  return wibox.widget {
    align = "center",
    valign = "center",
    text = "",
    widget = wibox.widget.textbox
  }
end

local function cmd(c)
  local f = assert(io.popen(c, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

function sys.ram()
  local wi = txtbox()

  gears.timer {
    timeout = 1,
    autostart = true,
    callback = function()
      wi.text = cmd(" " .. "free | grep Mem | awk '{print $3/$2 * 100.0}'" .. " ")
    end
  }

  return wi
end

return sys
