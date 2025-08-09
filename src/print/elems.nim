## Defines elements of fletchling's appearance

from ../utils/colors import fg


# TODO: make configurable
const
  border* = ["─", "│", "─", "│", "╭", "╮", "╯", "╰"]
  borderColor* = fg.cy

  groupIcons* = ["", "󰌽", "", "", "", "󰥔", "󰏔"]
  groupNames* = ["user", "os", "kernel", "desktop", "shell", "uptime", "pkgs"]
