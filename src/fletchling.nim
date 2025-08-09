## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces

import
  ./config/[vars, optTracker],
  ./print/[art, text, fetchResults],
  ./utils/seqs

# Categories of info
let groups = formatGroups(
  vars.paletteIcon, vars.noFmt.get, vars.noNerdFont.get
)
let (values, distro) = fetchResults()

if vars.noArt.get:
  echo "" # Leading line as extra space before content
  for (group, value) in zip(groups, values):
    echo group, " ", value
else:
  let
    monoArt = getMonoArt(distro)
    artPad = spaces(maxLen(monoArt)) # The same width as the art, used for printing

  var finalArt = @[artPad] # Vertical padding to align the art with the text

  if vars.noFmt.get:
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
