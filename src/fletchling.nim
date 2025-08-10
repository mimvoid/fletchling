## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces
from std/options import isSome, get

from ./config/opts import parseOptions
import
  ./print/[art, text, fetchResults],
  ./utils/seqs

let varOpts = parseOptions()
if varOpts.isSome:
  let
    vars = varOpts.get()
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
      artPad = spaces(maxLen(monoArt)) # The same width as the art, used for printing

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
