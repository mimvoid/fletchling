## `fletchling` by mimvoid

from std/sequtils import repeat, zip, concat, newSeqWith
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
var text = zip(groups, values)

if vars.noArt:
  for (group, value) in text:
    printStr.add('\n' & group & ' ' & value)
else:
  var finalArt =
    if vars.noFmt: getMonoArt(distro)
    else: getStyledArt(distro)

  # Vertical alignment
  let lenDiff = len(finalArt) - len(groups)

  if lenDiff > 0:
    if lenDiff >= 2:
      # Center groups and values vertically
      let padding = newSeq[(string, string)](lenDiff div 2)
      text = concat(padding, text, padding)

    if lenDiff mod 2 == 1:
      # If there is an odd difference, add another line
      text.add(("", ""))
  elif lenDiff < 0:
    let monoArt =
      if vars.noFmt: finalArt
      else: getMonoArt(distro)

    if lenDiff <= -2:
      # Center art vertically
      let padding = newSeqWith(-lenDiff div 2, spaces(len(monoArt[0])))
      finalArt = concat(padding, finalArt, padding)

    if -lenDiff mod 2 == 1:
      finalArt.add("")


  for (art, txt) in zip(finalArt, text):
    printStr.add('\n' & art & ' ' & txt[0] & ' ' & txt[1])

echo(printStr)
