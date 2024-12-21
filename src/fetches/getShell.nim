from std/strutils import split
import ../utils/fetch


proc getShell*(): string =
  let shell = getEnvValues("SHELL")
  return shell.split("/")[^1]
