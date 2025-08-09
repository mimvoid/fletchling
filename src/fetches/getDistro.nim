## Fetches the distro name and version

from std/posix_utils import osReleaseFile
from std/parsecfg import loadConfig, getSectionValue
from std/strutils import toLowerAscii

when system.hostOs == "maxosx" or system.hostOs == "windows":
  from ../utils/fetch import getCommandOutput


type
  Distro = tuple
    name: string
    version: string


proc getDistro*(): Distro =
  const os = system.hostOS

  when os == "macosx":
    let version = getCommandOutput("sw_vers -productVersion")
    return ("macos", version)

  elif os == "windows":
    let output = getCommandOutput("wmic os get caption")

    if output == "":
      return (os, "")

    return (os, output.split("\r\r\n")[1])

  else:
    try:
      # Read os-release file for linux & bsd distros
      let
        osInfo = osReleaseFile()
        osName = osInfo.getSectionValue("", "NAME")
        version = osInfo.getSectionValue("", "VERSION_ID")
        name =
          if osName != "": toLowerAscii(osName)
          else: os

      return (name, version)
    except IOError:
      return (os, "")
