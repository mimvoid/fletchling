## `fletchling` by mimvoid

from std/sequtils import repeat, zip
from std/strutils import spaces

import
  ./fetches/getDistro,
  ./print/[art, text, fetchResults],
  ./config/[vars, optTracker],
  ./utils/seqs


# Art

let
  (distro, _) = getDistro()

  monoArt = getMonoArt(distro)
  styledArt = getStyledArt(distro)

  # Spaces the same width as the art, used for printing
  artPad = spaces(maxLen(monoArt))

var finalArt =
  if vars.noColor.get: monoArt
  else: styledArt

# Vertical padding to align the art with the text
finalArt = @[artPad] & finalArt


# Groups

let
  groups = styledGroups(vars.nerdFont.get) # Categories of info (user, palette, etc.)
  lenGroups = len(groups)

# Determine if the art needs more padding for printing
if lenGroups > len(monoArt):
  finalArt &= artPad.repeat(lenGroups - len(finalArt))


# Printing

echo "" # Leading line as extra space before content
for (art, text) in zip(finalArt, zip(groups, fetchResults())):
  echo art, "  ", text[0], " ", text[1]
