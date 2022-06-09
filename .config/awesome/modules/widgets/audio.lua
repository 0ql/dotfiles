local wibox = require("wibox")
local gears = require("gears")

local function txtbox(default)
  return wibox.widget {
    align = "center",
    valign = "center",
    text = default or "",
    widget = wibox.widget.textbox
  }
end

local function cmd(c)
  local f = assert(io.popen(c, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

local function updateVol()
  audio.volumebox.text = cmd("pamixer --get-volume-human")
end

audio = audio or {
  volumebox = txtbox(cmd("pamixer --get-volume-human"))
}

function audio.incVol()
  cmd("pamixer -i 5")
  updateVol()
end

function audio.decVol()
  cmd("pamixer -d 5")
  updateVol()
end

function audio.defaultSink()
  local wi = txtbox()

  gears.timer {
    timeout = 1,
    autostart = true,
    callback = function()
      -- wi.text = cmd("pactl list sinks short | grep 'RUNNING' | grep -oP '((?<=alsa_output\\.)([^\\.])*|\\d*Hz)' | sed -e 's/_/ /g' | xargs")
      wi.text = cmd("pamixer --get-default-sink | cut -d ' ' -f 3- | sed -e 's/\"//g' | xargs")
    end
  }

  return wi
end

return audio
