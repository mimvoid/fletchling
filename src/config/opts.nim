## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Command line arguments

import std/[parsecfg, parseopt, paths]
from std/appDirs import getConfigDir
from std/os import fileExists
from std/options import Option, some, none

import ./[borders, optTracker]


type FletchlingOpts = tuple
  noFmt, noNerdFont, noArt: bool
  paletteIcon: string
  borderKind: Border


const version = "0.1.0"
const helpMsg = """
A light and stylish fetcher written in Nim

Usage:
  fletchling [OPTIONS]

Options:
  -h, --help          Show this message and exit
  -v, --version       Show version and exit
  -F, --no-format     Print without color and formatting ANSI codes
  -N, --no-nerd-font  Print without nerd font icons
  -A, --no-art        Print without art
  -p, --palette-icon  Character used to display terminal colors
  -b, --border        Border style, one of "single", "bold", "double", or "rounded"
"""

proc parseOptions*(): Option[FletchlingOpts] =
  var
    noFmt = initOptTracker(false)
    noNerdFont = initOptTracker(false)
    noArt = initOptTracker(false)
    paletteIcon = initOptTracker("")
    borderKind = initOptTracker(Border.rounded)

  # Parse command line arguments
  for kind, key, val in getopt():
    case kind:
    of cmdLongOption:
      case key:
      of "help":
        echo(helpMsg)
        return options.none(FletchlingOpts)
      of "version":
        echo(version)
        return options.none(FletchlingOpts)
      of "no-format":
        noFmt.setBoolArg(val)
      of "no-nerd-font":
        noNerdFont.setBoolArg(val)
      of "no-art":
        noArt.setBoolArg(val)
      of "palette-icon":
        paletteIcon.set(val)
      of "border":
        borderKind.setParse(val)
    of cmdShortOption:
      case key:
      of "h":
        echo(helpMsg)
        return options.none(FletchlingOpts)
      of "v":
        echo(version)
        return options.none(FletchlingOpts)
      of "F":
        noFmt.setBoolArg(val)
      of "N":
        noNerdFont.setBoolArg(val)
      of "A":
        noArt.setBoolArg(val)
      of "p":
        paletteIcon.set(val)
      of "b":
        borderKind.setParse(val)
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

    if not borderKind.isSet:
      borderKind.setParse(cfg.getSectionValue("", "border"))


  if (not paletteIcon.isSet) and noNerdFont.get:
    paletteIcon.set("@")

  return some(
    (noFmt.get, noNerdFont.get, noArt.get, paletteIcon.get, borderKind.get)
  )
