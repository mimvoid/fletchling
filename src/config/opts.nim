## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Command line arguments

import std/[parsecfg, parseopt, paths, streams]
from std/logging import warn, error, setLogFilter, lvlError, lvlAll
from std/strutils import format
from std/appDirs import getConfigDir

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
  -q, --quiet         Disable all logs except errors
  -V, --verbose       Enable verbose logging
"""

var quiet = false

var
  noFmt = static: initOptTracker(false)
  noNerdFont = static: initOptTracker(false)
  noArt = static: initOptTracker(false)
  paletteIcon = static: initOptTracker("")
  borderKind = static: initOptTracker(Border.rounded)


proc parseArgs() {.inline.} =
  ## Parse command line arguments

  # In case any of the arguments is --quiet or -q, store warnings until
  # every argument is parsed
  var warns: seq[string] = @[]

  for kind, key, val in getopt():
    let long = kind == cmdLongOption
    if not long and kind != cmdShortOption:
      continue

    template isOpt(longName, shortName: string): bool =
      (long and key == longName) or ((not long) and key == shortName)

    if isOpt("help", "h"):
      echo(helpMsg)
      quit(QuitSuccess)
    elif isOpt("version", "v"):
      echo(version)
      quit(QuitSuccess)

    try:
      if isOpt("quiet", "q"):
        setLogFilter(lvlError)
        quiet = true

      elif not quiet and isOpt("verbose", "V"):
        setLogFilter(lvlAll)

      elif isOpt("no-format", "F"):
        noFmt.setBoolArg(val)

      elif isOpt("no-nerd-font", "N"):
        noNerdFont.setBoolArg(val)

      elif isOpt("no-art", "A"):
        noArt.setBoolArg(val)

      elif isOpt("palette-icon", "p"):
        paletteIcon.set(val)

      elif isOpt("border", "b"):
        borderKind.setParse(val)

      else:
        let prefix = if long: "--" else: "-"
        warns.add("Skipping unknown option: $1$2".format(prefix, key))

    except ValueError:
      let prefix = if long: "--" else: "-"
      if val == "":
        warns.add("No value given for option $1$2".format(prefix, key))
      else:
        warns.add("Could not parse option $1$2: $3".format(prefix, key, val))

  if not quiet:
    for i in warns: warn(i)


proc parseConfig() {.inline.} =
  ## Parse config file

  let configFile = $(getConfigDir() / Path("fletchling") / Path("config.ini"))
  var f = newFileStream(configFile, fmRead)
  if f == nil:
    return

  var cfg: CfgParser
  cfg.open(f, configFile)
  defer: cfg.close()

  template tryParse[T](opt: OptTracker[T], value: string): untyped =
    if not opt.isSet:
      try:
        opt.setParse(value)
      except ValueError:
        warn(cfg.warningStr("Couldn't parse value, skipping."))

  var section = ""
  while true:
    var e = cfg.next()
    case e.kind:
    of cfgEof: break
    of cfgSectionStart:
      section = e.section
    of cfgKeyValuePair:
      if section == "":
        case e.key:
        of "noFormatting": tryParse(noFmt, e.value)
        of "noNerdFont": tryParse(noNerdFont, e.value)
        of "paletteIcon": tryParse(paletteIcon, e.value)
        of "border": tryParse(borderKind, e.value)
        else:
          warn(cfg.warningStr("Skipping unknown option"))
    of cfgOption:
      discard
    of cfgError:
      error(e.msg)


proc parseOptions*(): FletchlingOpts =
  parseArgs()
  parseConfig()

  if (not paletteIcon.isSet) and noNerdFont.get:
    paletteIcon.set("@")

  return (noFmt.get, noNerdFont.get, noArt.get, paletteIcon.get, borderKind.get)
