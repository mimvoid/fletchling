from std/posix_utils import osReleaseFile
from std/parsecfg import loadConfig, getSectionValue
from std/strutils import toLowerAscii


type
  Distro = tuple
    name: string
    version: string


proc getDistro*(): Distro =
  try:
    # Read os-release file for linux & bsd distros
    let
      osInfo = osReleaseFile()
      name = osInfo.getSectionValue("", "NAME")
      version = osInfo.getSectionValue("", "VERSION_ID")

    return (toLowerAscii(name), version)
  except IOError:
    let os = system.hostOS

    case os
    of "macosx":
      return ("macos", "")
    else:
      return (os, "")
