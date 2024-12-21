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
  categories = styledCategories(vars.nerdFont)
  longer = longestItem(@[monoArt, categories])

if longer == categories:
  finalArt &= artPad.repeat(len(categories) - len(finalArt))


let fetchResults = [
  "",
  getUsername() & "@" & getHostname(),
  distro & " " & version,
  getKernel(),
  getDesktop(),
  getShell(),
  getUptime(),
  getPackages(),
  "",
  ""
]


echo ""

for (art, text) in zip(finalArt, zip(categories, fetchResults)):
  echo art, "  ", text[0], " ", text[1]
