## Fetches the distro name and version

when hostOs == "macosx" or hostOs == "windows":
  from ../utils/fetch import getCommandOutput
  if hostOs == "windows":
    from std/strutils import split
else:
  from std/posix_utils import osReleaseFile
  from std/parsecfg import loadConfig, getSectionValue
  from std/strutils import toLowerAscii


type Distro = tuple[name, version: string]

proc getDistro*(): Distro {.inline.} =
  when hostOs == "macosx":
    let version = getCommandOutput("sw_vers -productVersion")
    return ("macos", version)

  elif hostOs == "windows":
    let output = getCommandOutput("wmic os get caption")

    if output == "":
      return (hostOs, "")

    return (hostOs, output.split("\r\r\n")[1])

  else:
    try:
      # Read os-release file for linux & bsd distros
      let
        osInfo = osReleaseFile()
        osName = osInfo.getSectionValue("", "NAME")
        version = osInfo.getSectionValue("", "VERSION_ID")
        name =
          if osName != "": toLowerAscii(osName)
          else: hostOs

      return (name, version)
    except IOError:
      return (hostOs, "")
