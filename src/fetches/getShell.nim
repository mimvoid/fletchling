## Fetches the shell program

from std/strutils import split
import ../utils/fetch


proc getShell*(): string =
  let shell = getEnvValues("SHELL")

  if shell == "":
    return

  return shell.split("/")[^1]
