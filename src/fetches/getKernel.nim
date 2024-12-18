from std/posix_utils import uname

proc getKernel*(): string =
  if system.hostOS == "haiku":
    try:
      return uname().version
    except OSError:
      return ""

  try:
    return uname().release
  except OSError:
    return ""
