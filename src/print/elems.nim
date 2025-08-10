## Defines elements of fletchling's appearance

from ../utils/colors import fg


# TODO: make configurable
const
  borderColor* = static: fg.cy
  groupIcons* = static: ["", "󰌽", "", "", "", "󰥔", "󰏔"]
  groupNames* = static: ["user", "os", "kernel", "desktop", "shell", "uptime", "pkgs"]
