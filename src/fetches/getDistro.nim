## Fetches the distro name and version

from std/posix_utils import osReleaseFile
from std/parsecfg import loadConfig, getSectionValue
from std/strutils import toLowerAscii

from ../utils/fetch import getCmdResult


type
  Distro = tuple
    name: string
    version: string


proc getDistro*(): Distro =
  const os = system.hostOS

  when os == "macosx":
    let version = getCmdResult("sw_vers -productVersion")
    return ("macos", version)

  elif os == "windows":
    let res = getCmdResult("wmic os get caption")

    if res == "":
      return (os, "")

    return (os, res.split("\r\r\n")[1])

  else:
    try:
      # Read os-release file for linux & bsd distros
      let
        osInfo = osReleaseFile()
        name = osInfo.getSectionValue("", "NAME")
        version = osInfo.getSectionValue("", "VERSION_ID")

      if name == "":
        return (os, version)

      return (toLowerAscii(name), version)
    except IOError:
      return (os, "")
