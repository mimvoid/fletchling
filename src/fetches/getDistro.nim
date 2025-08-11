## Fetches the distro name and version

when hostOs == "macosx" or hostOs == "windows":
  from ../utils/fetch import getCommandOutput
  if hostOs == "windows":
    from std/strutils import split
else:
  from std/posix_utils import osReleaseFile
  from std/parsecfg import loadConfig, getSectionValue
  from std/strutils import toLowerAscii


type Distro = tuple[name, id, idLike, version: string]

proc getDistro*(): Distro {.inline.} =
  when hostOs == "macosx":
    let version = getCommandOutput("sw_vers -productVersion")
    return (hostOs, hostOs, hostOs, version)

  elif hostOs == "windows":
    var output = getCommandOutput("wmic os get caption")

    if output != "":
      output = output.split("\r\r\n")[1]

    return (hostOs, hostOs, hostOs, output)

  else:
    try:
      # Read os-release file for linux & bsd distros
      let osInfo = osReleaseFile()
      let
        name =
          if (let osName = osInfo.getSectionValue("", "NAME"); osName != ""):
            toLowerAscii(osName)
          else: hostOs

        id = osInfo.getSectionValue("", "ID")
        idLike =
          if (let likeVal = osInfo.getSectionValue("", "ID_LIKE"); likeVal != ""):
            likeVal
          else: id

        version = osInfo.getSectionValue("", "VERSION_ID")

      return (name, id, idLike, version)
    except IOError:
      return (hostOs, hostOs, hostOs, "")
