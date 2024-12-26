from std/strutils import toLowerAscii
import ../utils/fetch


proc getDesktop*(): string =
  let desktop = getEnvValues("XDG_CURRENT_DESKTOP", "DESKTOP_SESSION", "WINDOWMANAGER")
  return toLowerAscii(desktop)
