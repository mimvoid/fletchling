from std/sequtils import repeat, zip
from std/strutils import spaces

import
  ./fetches/[
    getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages
  ],
  ./print/[art, text],
  ./config/vars,
  ./utils/seq


let
  (distro, version) = getDistro()

  monoArt = getMonoArt(distro)
  styledArt = getStyledArt(distro)

  artPad = spaces(len(longestItem(monoArt)))

var finalArt =
  if vars.noColor: monoArt
  else: styledArt

finalArt = @[artPad] & finalArt


let
  groups = styledGroups(vars.nerdFont)
  longer = longestItem(@[monoArt, groups])

if longer == groups:
  finalArt &= artPad.repeat(len(groups) - len(finalArt))


let fetchResults = [
  "",
  getUsername() & "@" & getHostname(),
  distro & " " & version,
  getKernel(),
  getDesktop(),
  getShell(),
  getUptime(),
  getPackages(distro),
  "",
  ""
]


echo ""

for (art, text) in zip(finalArt, zip(groups, fetchResults)):
  echo art, "  ", text[0], " ", text[1]
