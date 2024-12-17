from std/envvars import existsEnv, getEnv
from std/strutils import toLowerAscii, rsplit

proc getEnvValues(envVars: varargs[string]): string =
  for i in items(envVars):
    if not existsEnv(i): continue
    return getEnv(i)

  return ""

proc getShell*(): string =
  let
    shell = getEnvValues("SHELL")
    base = rsplit(shell, "/", maxsplit=1)

  return base[1]

proc getDesktop*(): string = 
  let desktop = getEnvValues("XDG_CURRENT_DESKTOP", "DESKTOP_SESSION")
  return toLowerAscii(desktop)
