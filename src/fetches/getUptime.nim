## Fetches and formats the uptime

from std/os import fileExists
from std/strformat import fmt
import std/[strutils, syncio]


func formatTime(seconds: uint): string =
  ## Formats seconds into minutes, hours, and days.
  ## Example: 1d 9h 42m

  let
    minutes = seconds div 60 mod 60
    hours = seconds div 3600 mod 24
    days = seconds div 86400

  if hours == 0:
    return fmt"{minutes}m"

  if days == 0:
    return fmt"{hours}h {minutes}m"

  return fmt"{days}d {hours}h {minutes}m"


proc getUptime*(): string =
  if "/proc/uptime".fileExists:
    let
      uptime = readFile("/proc/uptime").split(".")[0]
      seconds = parseUInt(uptime)

    return formatTime(seconds)

  return ""
