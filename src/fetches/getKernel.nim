## Fetches the kernel version

from std/posix_utils import uname
from std/os import fileExists
from std/syncio import readFile
from std/strutils import split

from ../utils/fetch import getCmdResult


proc getKernel*(): string =
  const os = system.hostOS

  when os == "haiku":
    try:
      return uname().version
    except OSError:
      return ""

  elif os == "windows":
    return getCmdResult("wmic os get Version").split("\r\r\n")[1]

  try:
    return uname().release
  except OSError:
    if "/proc/version".fileExists():
      return readFile("/proc/version").split[2]

    return ""
