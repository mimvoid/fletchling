## Fetches the kernel version

when hostOS == "windows":
  from ../utils/fetch import getCommandOutput
  from std/strutils import split
else:
  from std/posix_utils import uname

when hostOS != "haiku":
  from std/strutils import split
  from std/asyncdispatch import waitFor
  from std/asyncfile import openAsync, readLine, close


proc getKernel*(): string {.inline.} =
  when hostOS == "windows":
    let version = getCommandOutput("wmic os get Version")
    if version != "":
      return version.split("\r\r\n")[1]

  elif hostOS == "haiku":
    try:
      return uname().version
    except OSError:
      return

  else:
    try:
      return uname().release
    except OSError:
      try:
        let f = openAsync("/proc/version", fmRead)
        defer: f.close()

        let content = waitFor readLine(f)
        return content.split()[2]
      except OsError:
        return
