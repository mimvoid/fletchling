## Defines default configuration settings and checks for custom settings.
##
## In level of importance:
## Default values < Config file < Command line arguments

import std/[parseopt, paths, strutils]
from std/logging import warn, error, setLogFilter, lvlError, lvlAll

import ./borders


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

var
  quiet = false
  noFmt = false
  noNerdFont = false
  noArt = false
  paletteIcon = ""
  borderKind = Border.rounded


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
        noFmt = parseBool(val)
      elif isOpt("no-nerd-font", "N"):
        noNerdFont = parseBool(val)
      elif isOpt("no-art", "A"):
        noArt = parseBool(val)
      elif isOpt("palette-icon", "p"):
        paletteIcon = val
      elif isOpt("border", "b"):
        borderKind = parseEnum[Border](val)
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


proc parseOptions*(): FletchlingOpts =
  parseArgs()

  if paletteIcon == "":
    paletteIcon = if noNerdFont: "@" else: ""

  return (noFmt, noNerdFont, noArt, paletteIcon, borderKind)
