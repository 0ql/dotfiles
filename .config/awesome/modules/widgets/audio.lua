local wibox = require("wibox")
local gears = require("gears")

local audio = {}

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

function audio.runningSink()
  local wi = txtbox()

  gears.timer {
    timeout = 1,
    autostart = true,
    callback = function()
      wi.text = cmd("pactl list sinks short | grep 'RUNNING' | grep -oP '((?<=alsa_output\\.)([^\\.])*|\\d*Hz)' | sed -e 's/_/ /g' | xargs")
    end
  }

  return wi
end

function audio.runningSource()
  local wi = txtbox()

  gears.timer {
    timeout = 1,
    autostart = true,
    callback = function()
      wi.text = cmd("pactl list sources short | grep 'RUNNING' | grep -oP '((?<=alsa_output\\.)([^\\.])*|\\d*Hz)' | sed -e 's/_/ /g' | xargs")
    end
  }

  return wi
end

return audio
