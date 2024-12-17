from std/strutils import rsplit
import ../utils/env

proc getShell*(): string =
  let
    shell = getEnvValues("SHELL")
    base = rsplit(shell, "/", maxsplit=1)

  return base[1]
