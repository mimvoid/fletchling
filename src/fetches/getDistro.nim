from std/os import fileExists
from std/parsecfg import loadConfig, getSectionValue
from std/strutils import toLowerAscii

type
  Distro = tuple
    name: string
    version: string

proc getDistro*(): Distro =
  var os = system.hostOS

  if os == "linux":
    let osInfo = "/etc/os-release"

    if osInfo.fileExists():
      let
        cfg = osInfo.loadConfig
        name = cfg.getSectionValue("", "NAME")
        version = cfg.getSectionValue("", "VERSION_ID")

      return (toLowerAscii(name), version)
    else:
      return ("", "")
  elif os == "macosx":
    return ("macos", "")
  else:
    return (system.hostOS, "")
