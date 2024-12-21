from std/posix_utils import uname


proc getKernel*(): string =
  const os = system.hostOS

  when os == "haiku":
    try:
      return uname().version
    except OSError:
      return ""

  try:
    return uname().release
  except OSError:
    return ""
