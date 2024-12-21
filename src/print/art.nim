import std/tables
import ./[monoArt, styledArt]


proc getMonoArt*(distro: string): seq[string] =
  return getOrDefault(monoArt.art, distro)


proc getStyledArt*(distro: string): seq[string] =
  return getOrDefault(styledArt.art, distro)
