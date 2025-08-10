## Fetches the kernel version

const isWindows = hostOS == "windows"
const isHaiku = hostOS == "haiku"

when isWindows:
  from ../utils/fetch import getCommandOutput
else:
  from std/posix_utils import uname
  when not isHaiku:
    from std/os import fileExists
    from std/syncio import readFile
    from std/strutils import split


proc getKernel*(): string =
  when isWindows:
    let version = getCommandOutput("wmic os get Version")
    if version != "":
      return version.split("\r\r\n")[1]

  elif isHaiku:
    try:
      return uname().version
    except OSError:
      return

  else:
    try:
      return uname().release
    except OSError:
      if "/proc/version".fileExists():
        return readFile("/proc/version").split()[2]
