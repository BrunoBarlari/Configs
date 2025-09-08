local colors = require("colors").sections.bar

sbar.bar {
  topmost = "window",
  height = 41,
  notch_display_height = 41,
  padding_right = 12,
  padding_left = 12,
  margin = 10,  -- Match Aerospace outer gaps
  corner_radius = 12,  -- Match macOS native window corner radius
  y_offset = 10,  -- Add top margin to match gaps
  blur_radius = 20,
  border_color = colors.border,
  border_width = 1,
  color = colors.bg,
}
