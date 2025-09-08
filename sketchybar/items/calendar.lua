local icons = require("icons")
local colors = require("colors").sections.calendar
local settings = require("settings")

local cal = sbar.add("item", {
  icon = {
    string = icons.calendar,
    padding_left = 8,
    padding_right = 4,
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
    },
  },
  label = {
    color = colors.label,
    align = "left",
    padding_right = 8,
  },
  padding_left = 10,
  position = "right",
  update_freq = 30,
})

-- Calendar popup with events
local cal_popup = sbar.add("item", {
  position = "popup." .. cal.name,
  background = {
    border_width = 2,
    corner_radius = 12,
    border_color = colors.border or 0xff494d64,
    color = colors.bg or 0xff1e1e2e,
  },
  width = 250,
  align = "center",
})

-- Get today's events from Calendar
local function get_calendar_events()
  local handle = io.popen([[
    osascript -e '
    tell application "Calendar"
      set todayStart to (current date) - (time of (current date))
      set todayEnd to todayStart + (24 * 60 * 60) - 1
      set eventList to {}
      repeat with cal in calendars
        set calEvents to (every event of cal whose start date ≥ todayStart and start date ≤ todayEnd)
        repeat with evt in calEvents
          set end of eventList to (summary of evt & " - " & (time string of start date of evt))
        end repeat
      end repeat
      return my listToString(eventList)
    end tell

    on listToString(lst)
      set AppleScript'"'"'s text item delimiters to "\\n"
      set str to lst as string
      set AppleScript'"'"'s text item delimiters to ""
      return str
    end listToString'
  ]])

  if handle then
    local result = handle:read("*a")
    handle:close()
    return result:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
  end
  return "No events today"
end

-- Animation for click
cal:subscribe("mouse.clicked", function()
  -- Open Calendar app
  os.execute("open -a 'Calendar'")

  -- Animate click feedback
  sbar.animate("tanh", 8, function()
    cal:set {
      background = {
        shadow = {
          distance = 0,
        },
      },
      y_offset = -4,
      padding_left = 14,
      padding_right = 0,
    }
    cal:set {
      background = {
        shadow = {
          distance = 4,
        },
      },
      y_offset = 0,
      padding_left = 10,
      padding_right = 4,
    }
  end)
end)

-- Show/hide popup on hover
cal:subscribe("mouse.entered", function()
  local events = get_calendar_events()
  cal_popup:set({
    label = {
      string = events,
      color = colors.label,
      padding_left = 10,
      padding_right = 10,
    },
    drawing = true,
  })
end)

cal:subscribe("mouse.exited", function()
  cal_popup:set({ drawing = false })
end)

-- Update time and date
cal:subscribe({ "forced", "routine", "system_woke" }, function()
  local time = os.date("%H:%M")
  local date = os.date("%a %d %b")
  cal:set {
    label = time .. " " .. date,
  }
end)
