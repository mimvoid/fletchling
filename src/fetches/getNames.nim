## Fetches the username and hostname

from std/os import fileExists
from std/posix_utils import uname
from std/strbasics import strip

from std/asyncdispatch import waitFor
import std/[parsecfg, asyncfile]

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

    if fileExists("/etc/hostname"):
      let f = openAsync("/etc/hostname", fmRead)
      defer: f.close()

      var content = waitFor readLine(f)
      content.strip()
      return content

    const hostRc = "/etc/conf.d/hostname"
    if hostRc.fileExists():
      return loadConfig(hostRc).getSectionValue("", "hostname")
