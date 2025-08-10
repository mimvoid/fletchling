## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Command line arguments

import std/[parsecfg, parseopt, paths]
from std/appDirs import getConfigDir
from std/os import fileExists
import ./optTracker


type FletchlingOpts = tuple
  noFmt, noNerdFont, noArt: bool
  paletteIcon: string


proc parseOptions*(): FletchlingOpts =
  var
    noFmt = initOptTracker(false)
    noNerdFont = initOptTracker(false)
    noArt = initOptTracker(false)
    paletteIcon = initOptTracker("")

  # Parse command line arguments
  for kind, key, val in getopt():
    case kind:
    of cmdLongOption:
      case key:
      of "no-format":
        noFmt.setBoolArg(val)
      of "no-nerd-font":
        noNerdFont.setBoolArg(val)
      of "no-art":
        noArt.setBoolArg(val)
      of "palette-icon":
        paletteIcon.set(val)
    of cmdShortOption:
      case key:
      of "F":
        noFmt.setBoolArg(val)
      of "N":
        noNerdFont.setBoolArg(val)
      of "A":
        noArt.setBoolArg(val)
      of "p":
        paletteIcon.set(val)
    of cmdArgument, cmdEnd:
      discard


  # Parse config file
  let configFile = $(getConfigDir() / Path("fletchling") / Path("config.ini"))
  if fileExists(configFile):
    let cfg = loadConfig(configFile)

    if not noFmt.isSet:
      noFmt.setParse(cfg.getSectionValue("", "noColor"))

    if not noNerdFont.isSet:
      noNerdFont.setParse(cfg.getSectionValue("", "nerdFont"))

    if not noArt.isSet:
      noArt.setParse(cfg.getSectionValue("", "noArt"))

    if not paletteIcon.isSet:
      paletteIcon.set(cfg.getSectionValue("", "paletteIcon"))


  if (not paletteIcon.isSet) and noNerdFont.get:
    paletteIcon.set("@")

  return (noFmt.get, noNerdFont.get, noArt.get, paletteIcon.get)
