from std/posix_utils import osReleaseFile
from std/parsecfg import loadConfig, getSectionValue
from std/strutils import toLowerAscii


type
  Distro = tuple
    name: string
    version: string


proc getDistro*(): Distro =
  const os = system.hostOS

  when os == "windows":
    return (os, "")
  elif os == "macosx":
    return ("macos", "")
  else:
    try:
      # Read os-release file for linux & bsd distros
      let
        osInfo = osReleaseFile()
        name = osInfo.getSectionValue("", "NAME")
        version = osInfo.getSectionValue("", "VERSION_ID")

      return (toLowerAscii(name), version)
    except IOError:
      return (os, "")
