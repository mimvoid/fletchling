## Fetches the shell program

from std/envvars import existsEnv, getEnv
from std/strutils import rsplit


proc getShell*(): string {.inline.} =
  if existsEnv("SHELL"):
    let shell = getEnv("SHELL")
    return shell.rsplit('/', maxsplit = 1)[^1]
