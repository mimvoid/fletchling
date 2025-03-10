## Helpers for fetching information

from std/osproc import execCmdEx
from std/strutils import strip
from std/envvars import existsEnv, getEnv


proc getCmdResult*(cmd: string): string =
  ## Takes a command and returns the result.
  ##
  ## If there is an error, returns an empty string.

  let res = execCmdEx(cmd)

  # Check the exit code
  if res[1] == 0:
    return res[0].strip


proc getEnvValues*(envVars: varargs[string]): string =
  ## Takes 1 or more environment variables and
  ## returns the value of the first one that exists.
  ##
  ## If none exist, returns an empty string.

  for i in items(envVars):
    if existsEnv(i):
      return getEnv(i)
