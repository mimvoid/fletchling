from std/os import fileExists
from std/posix_utils import uname
from std/syncio import readFile
from std/strutils import strip
import ../utils/env

proc getUsername*(): string =
  return getEnvValues("USERNAME", "USER", "LOGNAME")

proc getHostname*(): string =
  let hostFile = "/etc/hostname"

  if hostFile.fileExists():
    return readFile(hostFile).strip

  try:
    return uname().nodename
  except OSError:
    return ""
