local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")

--{{---| Colors |---------------------------------------------------------------
--  font    = "Terminess Powerline 8"
--  font    = "Ohsnap 11"
  font    = "Monospace 11"
  markup = '<span font="' .. font .. '">'
  fontcolor = "#FFFFFF"

--{{---| Spacers |-----------------------------------------------------------------------
  spr = wibox.widget.textbox(" ")

--{{---| Clock | ---------------------------------------------------------------
  -- Textclock widget
  mytextclock = awful.widget.textclock(markup .. '%H:%M</span>')

  -- Calendar attached to the textclock
  local os = os
  local string = string
  local util = awful.util
  text_color = fontcolor
  today_color = "#FF7100"
  calendar_width = 21

  local calendar = nil
  local offset = 0

  local data = nil

  local function pop_spaces(s1, s2, maxsize)
     local sps = ""
     for i = 1, maxsize - string.len(s1) - string.len(s2) do
        sps = sps .. " "
     end
     return s1 .. sps .. s2
  end

  local function create_calendar()
     offset = offset or 0

     local now = os.date("*t")
     local cal_month = now.month + offset
     local cal_year = now.year
     if cal_month > 12 then
        cal_month = (cal_month % 12)
        cal_year = cal_year + 1
     elseif cal_month < 1 then
        cal_month = (cal_month + 12)
        cal_year = cal_year - 1
     end

     local last_day = os.date("%d", os.time({ day = 1, year = cal_year,
                                              month = cal_month + 1}) - 86400)
     local first_day = os.time({ day = 1, month = cal_month, year = cal_year})
     local first_day_in_week =
        os.date("%w", first_day)
     local result = "do lu ma me gi ve sa\n"
     for i = 1, first_day_in_week do
        result = result .. "   "
     end

     local this_month = false
     for day = 1, last_day do
        local last_in_week = (day + first_day_in_week) % 7 == 0
        local day_str = pop_spaces("", day, 2) .. (last_in_week and "" or " ")
        if cal_month == now.month and cal_year == now.year and day == now.day then
           this_month = true
           result = result ..
              string.format('<span weight="bold" foreground = "%s">%s</span>',
                            today_color, day_str)
        else
           result = result .. day_str
        end
        if last_in_week and day ~= last_day then
           result = result .. "\n"
        end
     end

     local header
     if this_month then
        header = os.date("%a %d %b %Y")
     else
        header = os.date("%B %Y", first_day)
     end
     return header, string.format('<span font="%s" foreground="%s">%s</span>',
                                  font, text_color, result)
  end

  function hide()
     if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
     end
  end

  function show(inc_offset)
     inc_offset = inc_offset or 0

     local save_offset = offset
     hide()
     offset = save_offset + inc_offset

     local header, cal_text = create_calendar()
     calendar = naughty.notify({ title = header,
                                 text = cal_text,
                                 timeout = 0, hover_timeout = 0.5, border_width = 0,
                                 bg = "#1a1a1add"
                              })
  end

  mytextclock:connect_signal("mouse::enter", function() show(0) end)
  mytextclock:connect_signal("mouse::leave", hide)
  mytextclock:buttons(util.table.join( awful.button({ }, 3, function() show(-1) end),
                                       awful.button({ }, 1, function() show(1) end)))
