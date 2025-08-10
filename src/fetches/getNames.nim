## Fetches the username and hostname

from std/os import fileExists
from std/posix_utils import uname
from std/syncio import readFile
from std/strutils import strip

import std/parsecfg

import ../utils/fetch


proc getUsername*(): string {.inline.} =
  let username = getEnvValues("USERNAME", "USER", "LOGNAME")

  if username == "":
    return getCommandOutput("whoami")

  return username


proc getHostname*(): string {.inline.} =
  try:
    return uname().nodename
  except OSError:
    let hostname = getCommandOutput("hostname")
    if hostname != "":
      return hostname

    const hostFile = "/etc/hostname"
    if hostFile.fileExists():
      return readFile(hostFile).strip

    const hostRc = "/etc/conf.d/hostname"
    if hostRc.fileExists():
      return loadConfig(hostRc).getSectionValue("", "hostname")
