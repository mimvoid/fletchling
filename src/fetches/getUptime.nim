## Fetches and formats the uptime

from std/strformat import fmt
from std/asyncdispatch import waitFor
import std/[strutils, asyncfile]


func formatTime(seconds: uint): string {.inline.} =
  ## Formats seconds into minutes, hours, and days.
  ## Example: 1d 9h 42m

  let
    minutes = seconds div 60 mod 60
    hours = seconds div 3600 mod 24

  if hours == 0:
    return fmt"{minutes}m"

  let days = seconds div 86400
  if days == 0:
    return fmt"{hours}h {minutes}m"

  return fmt"{days}d {hours}h {minutes}m"


proc getUptime*(): string {.inline.} =
  try:
    var f = openAsync("/proc/uptime", fmRead)
    defer: f.close()

    let
      content = waitFor readLine(f)
      uptime = content.split('.', maxsplit = 1)[0]
      seconds = parseUInt(uptime)

    return formatTime(seconds)
  except OSError:
    return
