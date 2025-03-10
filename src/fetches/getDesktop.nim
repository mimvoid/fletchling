## Fetches the desktop environment or window manager

from std/strutils import toLowerAscii
import ../utils/fetch


proc getDesktop*(): string =
  let desktop = getEnvValues("XDG_CURRENT_DESKTOP", "DESKTOP_SESSION", "WINDOWMANAGER")

  if desktop == "":
    return

  return toLowerAscii(desktop)
