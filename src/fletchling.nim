## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces

import
  ./fetches/getDistro,
  ./print/[art, text, fetchResults],
  ./config/vars,
  ./utils/seq


# Art

let
  (distro, _) = getDistro()

  monoArt = getMonoArt(distro)
  styledArt = getStyledArt(distro)

  # Spaces the same width as the art, used for printing
  artPad = spaces(maxLen(monoArt))

var finalArt =
  if vars.noColor: monoArt
  else: styledArt

# Padding so the art aligns with the text
finalArt = @[artPad] & finalArt


# Groups

let
  groups = styledGroups(vars.nerdFont)  # Categories of info (user, palette, etc.)
  longer = longestItem(@[monoArt, groups])

# Determine if the art needs more padding for printing
if longer == groups:
  finalArt &= artPad.repeat(len(groups) - len(finalArt))


# Printing

# Leading line as extra space before content
echo ""

for (art, text) in zip(finalArt, zip(groups, fetchResults())):
  echo art, "  ", text[0], " ", text[1]
