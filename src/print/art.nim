## Procedures to get the art for a distro's name.
## If none are found, return an empty sequence.

import std/tables
import ./[artMono, artStyled]


proc getMonoArt*(distro: string): seq[string] {.inline.} =
  return getOrDefault(artMono.art, distro)


proc getStyledArt*(distro: string): seq[string] {.inline.} =
  return getOrDefault(artStyled.art, distro)
