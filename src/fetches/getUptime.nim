import std/[strutils, syncio]
from std/os import fileExists
from std/strformat import fmt

proc getUptime*(): string =
  if "/proc/uptime".fileExists:
    let
      uptime = readFile("/proc/uptime").strip.split(".")[0]
      seconds = parseUInt(uptime)

      minutes = seconds div 60 mod 60
      hours = seconds div 3600 mod 24
      days = seconds div 86400

    if hours == 0:
      return fmt"{minutes}m"
    elif days == 0:
      return fmt"{hours}h {minutes}m"
    else:
      return fmt"{days}d {hours}h {minutes}m"
  else:
    return ""
