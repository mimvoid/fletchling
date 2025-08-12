## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces
import std/logging

from ./config/opts import parseOptions
import
  ./print/[formatText, fetchResults],
  ./art/art


# Register loggers
var console = newConsoleLogger(
  fmtStr = "$levelName: ",
  levelThreshold = lvlNotice
)
addHandler(console)


let vars = parseOptions()
let
  # Categories of info
  groups = formatGroups(
    vars.borderKind, vars.paletteIcon, vars.noFmt, vars.noNerdFont
  )
  (values, distro) = fetchResults()

# Store a string to echo it in one go. This is often better than printing many times.
var printStr = ""

if vars.noArt:
  for (group, value) in zip(groups, values):
    printStr.add('\n' & group & ' ' & value)
else:
  let
    monoArt = getMonoArt(distro)
    artPad = spaces(len(monoArt[0])) # The width of the art, used for alignment

  var finalArt = @[artPad] # Vertical padding to align the art with the text

  if vars.noFmt:
    finalArt.add(monoArt)
  else:
    finalArt.add(getStyledArt(distro))

  # Determine if the art needs more padding for printing
  let lenDiff = len(groups) - len(finalArt)
  if lenDiff > 0:
    finalArt.add(artPad.repeat(lenDiff))

  for (art, text) in zip(finalArt, zip(groups, values)):
    printStr.add('\n' & art & ' ' & text[0] & ' ' & text[1])

echo(printStr)
