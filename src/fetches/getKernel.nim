from std/posix_utils import uname

proc getKernel*(): string =
  try:
    return uname().release
  except OSError:
    return ""
