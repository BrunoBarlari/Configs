local icons = require("icons")
local colors = require("colors").sections.widgets.git
local settings = require("settings")

local git = sbar.add("item", {
  icon = {
    string = icons.git.branch,
    padding_left = 8,
    padding_right = 4,
    color = colors.icon,
    font = {
      family = settings.font.text,
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
  update_freq = 300, -- Update every 5 minutes
})

-- Git popup with detailed info
local git_popup = sbar.add("item", {
  position = "popup." .. git.name,
  background = {
    border_width = 2,
    corner_radius = 12,
    border_color = colors.border or 0xff494d64,
    color = colors.bg or 0xff1e1e2e,
  },
  width = 300,
  align = "center",
})

-- Check if gh CLI is installed and authenticated
local function check_gh_cli()
  local handle = io.popen("which gh 2>/dev/null")
  if not handle then return false end

  local result = handle:read("*a")
  handle:close()

  if result == "" then return false end

  -- Check if authenticated
  handle = io.popen("gh auth status 2>/dev/null")
  if not handle then return false end

  result = handle:read("*a")
  handle:close()

  return result:find("Logged in") ~= nil
end

-- Get GitHub notifications (PRs, issues, etc.)
local function get_github_notifications()
  if not check_gh_cli() then
    return "gh CLI not installed or not authenticated"
  end

  local handle = io.popen([[
    gh api notifications --paginate \
      --jq '.[] | select(.unread == true) | "\(.subject.type): \(.subject.title)"' \
      2>/dev/null | head -10
  ]])

  if handle then
    local result = handle:read("*a")
    handle:close()

    if result == "" then
      return "No new notifications"
    end

    return result:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
  end

  return "Failed to fetch notifications"
end

-- Get PR and issue counts
local function get_github_counts()
  if not check_gh_cli() then
    return { prs = 0, issues = 0, notifications = 0 }
  end

  local counts = { prs = 0, issues = 0, notifications = 0 }

  -- Get PR count
  local handle = io.popen('gh search prs --state=open --author="@me" --json number 2>/dev/null | jq length')
  if handle then
    local result = handle:read("*a")
    handle:close()
    counts.prs = tonumber(result) or 0
  end

  -- Get issue count
  handle = io.popen('gh search issues --state=open --author="@me" --json number 2>/dev/null | jq length')
  if handle then
    local result = handle:read("*a")
    handle:close()
    counts.issues = tonumber(result) or 0
  end

  -- Get notification count
  handle = io.popen('gh api notifications --jq "map(select(.unread == true)) | length" 2>/dev/null')
  if handle then
    local result = handle:read("*a")
    handle:close()
    counts.notifications = tonumber(result) or 0
  end

  return counts
end

-- Update git status display
local function update_git_status()
  local counts = get_github_counts()
  local total = counts.prs + counts.issues + counts.notifications

  if total == 0 then
    git:set({
      drawing = false
    })
    return
  end

  local label_parts = {}

  if counts.prs > 0 then
    table.insert(label_parts, icons.git.pr .. " " .. counts.prs)
  end

  if counts.issues > 0 then
    table.insert(label_parts, icons.git.issue .. " " .. counts.issues)
  end

  if counts.notifications > 0 then
    table.insert(label_parts, icons.git.notification .. " " .. counts.notifications)
  end

  git:set({
    label = table.concat(label_parts, " "),
    drawing = true
  })
end

-- Click to open GitHub in browser
git:subscribe("mouse.clicked", function()
  os.execute("open https://github.com/notifications")
end)

-- Show/hide popup on hover
git:subscribe("mouse.entered", function()
  local notifications = get_github_notifications()
  git_popup:set({
    label = {
      string = notifications,
      color = colors.label,
      padding_left = 10,
      padding_right = 10,
    },
    drawing = true,
  })
end)

git:subscribe("mouse.exited", function()
  git_popup:set({ drawing = false })
end)

-- Update git status
git:subscribe({ "forced", "routine", "system_woke" }, function()
  update_git_status()
end)

