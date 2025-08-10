## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces

from ./config/opts import parseOptions
import
  ./print/[art, text, fetchResults],
  ./utils/seqs

let
  vars = parseOptions()
  groups = formatGroups(vars.paletteIcon, vars.noFmt, vars.noNerdFont) # Categories of info
  (values, distro) = fetchResults()

if vars.noArt:
  echo "" # Leading line as extra space before content
  for (group, value) in zip(groups, values):
    echo group, " ", value
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

  echo ""
  for (art, text) in zip(finalArt, zip(groups, values)):
    echo art, "  ", text[0], " ", text[1]
