## Procedures to get the art for a distro's name.
## If none are found, return an empty sequence.

import std/tables
import ./[mono, styled]


proc getMonoArt*(distro: string): seq[string] {.inline.} =
  return getOrDefault(mono.art, distro, def = mono.art["linux"])


proc getStyledArt*(distro: string): seq[string] {.inline.} =
  return getOrDefault(styled.art, distro, def = styled.art["linux"])
