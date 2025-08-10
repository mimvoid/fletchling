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


const version = static: "0.1.0"
const helpMsg = static: """
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
  -b, --border        Border style, one of "none", "single", "bold", "double", or "rounded"
"""

proc parseOptions*(): Option[FletchlingOpts] =
  var
    noFmt = static: initOptTracker(false)
    noNerdFont = static: initOptTracker(false)
    noArt = static: initOptTracker(false)
    paletteIcon = static: initOptTracker("")
    borderKind = static: initOptTracker(Border.rounded)

  # Parse command line arguments
  for kind, key, val in getopt():
    case kind:
    of cmdLongOption, cmdShortOption:
      # Shorthands
      let l = kind == cmdLongOption
      func long(keyName: string): bool = l and key == keyName
      func short(keyName: string): bool = (not l) and key == keyName

      if "help".long or "h".short:
        echo(helpMsg)
        return options.none(FletchlingOpts)

      elif "version".long or "v".short:
        echo(version)
        return options.none(FletchlingOpts)

      elif "no-format".long or "F".short:
        noFmt.setBoolArg(val)

      elif "no-nerd-font".long or "N".short:
        noNerdFont.setBoolArg(val)

      elif "no-art".long or "A".short:
        noArt.setBoolArg(val)

      elif "palette-icon".long or "p".short:
        paletteIcon.set(val)

      elif "border".long or "b".short:
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
