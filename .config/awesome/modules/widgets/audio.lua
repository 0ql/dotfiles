local wibox = require("wibox")
local gears = require("gears")

local audio = {}

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function audio.update(instance)
  instance.textbox_widget.text = os.capture("pactl list sinks short | grep 'RUNNING' | grep -oP '((?<=alsa_output\\.)([^\\.])*|\\d*Hz)' | sed -e 's/_/ /g' | xargs", true)
end

function audio.create(args)
  args = args or {}
  args.timeout = args.timeout or 2

  local instance = {}

  instance.timer = gears.timer {
    timeout = args.timeout,
    autostart = true,
    callback = function() audio.update(instance) end
  }

  instance.textbox_widget = wibox.widget {
    -- wibox.widget.textbox arguments
    align = args.align or "center",
    ellipsize = args.ellipsize or nil,
    forced_height = args.forced_height or nil,
    forced_width = args.forced_width or nil,
    markup = args.markup or nil,
    opacity = args.opacity or nil,
    wrap = args.wrap or nil,
    text = "",
    valign = args.valign or "center",
    visible = args.visible or nil,
    widget = wibox.widget.textbox
  }

  return instance
end

return audio
