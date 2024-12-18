from std/os import fileExists
from std/posix_utils import uname
from std/syncio import readFile
from std/strutils import strip

import ../utils/[env, cmd]


proc getUsername*(): string =
  let username = env.getEnvValues("USERNAME", "USER", "LOGNAME")

  if username == "":
    return cmd.getCmdResult("whoami")

  return username


proc getHostname*(): string =
  let hostFile = "/etc/hostname"

  if hostFile.fileExists():
    return readFile(hostFile).strip

  try:
    return uname().nodename
  except OSError:
    return ""
