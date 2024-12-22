from std/osproc import execCmdEx
from std/strutils import strip
from std/envvars import existsEnv, getEnv


proc getCmdResult*(cmd: string): string =
  let res = execCmdEx(cmd)

  # Check the exit code
  if res[1] == 0:
    return res[0].strip

  return ""


proc getEnvValues*(envVars: varargs[string]): string =
  for i in items(envVars):
    if not existsEnv(i): continue
    return getEnv(i)

  return ""
