## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Commandline arguments

from std/os import fileExists
from std/appdirs import getConfigDir
import std/[strutils, paths, parsecfg]


# Default settings
var
  noColor* = false
  nerdFont* = true
  showArt* = true
  overrideArt* = false
  customArt* = ""


func getVal[T](cfg: Config, section, key: string, parser: proc, default: T): T =
  let val = cfg.getSectionValue(section, key)

  try:
    return parser(val)
  except ValueError:
    return default


# Get config file settings
let configFile = $getConfigDir().absolutePath & "fletchling/config.ini"

if configFile.fileExists():
  let cfg = loadConfig(configFile)

  noColor = cfg.getVal("", "noColor", parseBool, noColor)
  nerdFont = cfg.getVal("", "nerdFont", parseBool, nerdFont)

  showArt = cfg.getVal("Art", "showArt", parseBool, showArt)
  overrideArt = cfg.getVal("Art", "overrideArt", parseBool, overrideArt)
  customArt = cfg.getSectionValue("Art", "customArt", customArt)
