## Fetches the shell program

from std/envvars import existsEnv, getEnv
from std/strutils import split


proc getShell*(): string {.inline.} =
  if existsEnv("SHELL"):
    let shell = getEnv("SHELL")
    return shell.split("/")[^1]
