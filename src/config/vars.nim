## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Command line arguments

import std/[parsecfg, parseopt]
from std/os import fileExists
import ./[readConfig, optTracker]


var
  noColor* = initOptTracker(false)
  nerdFont* = initOptTracker(true)
  showArt* = initOptTracker(true)


# Parse command line arguments
for kind, key, val in getopt():
  case kind:
  of cmdLongOption:
    case key:
    of "no-color":
      noColor.setBoolArg(val)
    of "nerd-font":
      nerdFont.setBoolArg(val)
    of "show-art":
      showArt.setBoolArg(val)
  of cmdShortOption, cmdArgument, cmdEnd:
    discard


# Parse config file
if fileExists(configFile):
  let cfg = loadConfig(configFile)

  if not noColor.isSet:
    noColor.setParse(cfg.getSectionValue("", "noColor"))

  if not nerdFont.isSet:
    nerdFont.setParse(cfg.getSectionValue("", "nerdFont"))

  if not showArt.isSet:
    showArt.setParse(cfg.getSectionValue("", "showArt"))
