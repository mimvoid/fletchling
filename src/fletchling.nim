## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces

import
  ./fetches/getDistro,
  ./print/[art, text, fetchResults],
  ./config/[vars, optTracker],
  ./utils/seqs

# Categories of info
let groups = formatGroups(
  vars.paletteIcon, vars.noFmt.get, vars.noNerdFont.get
)
let values = fetchResults()

if vars.noArt.get:
  echo "" # Leading line as extra space before content
  for (group, value) in zip(groups, values):
    echo group, " ", value
else:
  let
    (distro, _) = getDistro()
    monoArt = getMonoArt(distro)
    styledArt = getStyledArt(distro)
    artPad = spaces(maxLen(monoArt)) # The same width as the art, used for printing

  var finalArt =
    if vars.noFmt.get: monoArt
    else: styledArt

  # Vertical padding to align the art with the text
  finalArt = @[artPad] & finalArt

  # Determine if the art needs more padding for printing
  let lenGroup = len(groups)
  if lenGroup > len(monoArt):
    finalArt &= artPad.repeat(lenGroup - len(finalArt))

  echo ""
  for (art, text) in zip(finalArt, zip(groups, values)):
    echo art, "  ", text[0], " ", text[1]
