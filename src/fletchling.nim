from std/sequtils import zip
from std/sugar import dump

import
  ./fetches/[
    getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages
  ],
  ./print/[art, text],
  ./config/vars,
  ./utils/style


let
  monoArt = getDistroArt(styled = false)
  ansiArt = getDistroArt(styled = true)

var finalArt = ansiArt
if vars.noColor:
  finalArt = monoArt


let
  categories = styledCategories()
  longer = longestItem(@[monoArt, categories])
  artPadding = seqPad(len(longer), monoArt)

finalArt = artPadding[0] & finalArt

if longer == categories:
  finalArt &= artPadding


let fetchResults = [
  "",
  getUsername() & "@" & getHostname(),
  getDistro().name & " " & getDistro().version,
  getKernel(),
  getShell(),
  getDesktop(),
  getUptime(),
  getPackages(),
  "",
  ""
]


echo ""

for i in zip(finalArt, zip(categories, fetchResults)):
  stdout.writeLine(i[0], "  ", i[1][0], " ", i[1][1])
