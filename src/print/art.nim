## Procedures to get the art for a distro's name.
## If none are found, return an empty sequence.

import std/tables
import ./[monoArt, styledArt]


proc getMonoArt*(distro: string): seq[string] =
  return getOrDefault(monoArt.art, distro)


proc getStyledArt*(distro: string): seq[string] =
  return getOrDefault(styledArt.art, distro)
