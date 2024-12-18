from std/strutils import toLowerAscii
import ../utils/env


proc getDesktop*(): string =
  let desktop = getEnvValues("XDG_CURRENT_DESKTOP", "DESKTOP_SESSION")
  return toLowerAscii(desktop)
