## Fetches the username and hostname

from std/os import fileExists
from std/posix_utils import uname
from std/syncio import readFile
from std/strutils import strip

import std/parsecfg

import ../utils/fetch


proc getUsername*(): string =
  let username = getEnvValues("USERNAME", "USER", "LOGNAME")

  if username == "":
    return getCmdResult("whoami")

  return username


proc getHostname*(): string =
  const
    hostFile = "/etc/hostname"
    hostRc = "/etc/conf.d/hostname"

  if hostFile.fileExists():
    return readFile(hostFile).strip

  if hostRc.fileExists():
    return loadConfig(hostRc).getSectionValue("", "hostname")

  try:
    return uname().nodename
  except OSError:
    return ""
