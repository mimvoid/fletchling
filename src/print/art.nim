import std/tables

import
  ./[monoArt, styledArt],
  ../fetches/getDistro


proc getDistroArt*(styled: bool): seq[string] =
  let distro = getDistro().name

  if styled and distro in styledArt.art:
    return styledArt.art[distro]

  if not styled and distro in monoArt.art:
    return monoArt.art[distro]

  return @[]
