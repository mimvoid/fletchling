from std/sugar import collect
from std/sequtils import zip
from std/unicode import alignLeft, runeLen
from std/strformat import fmt
from std/strutils import repeat, join

import std/terminal

from ./elems import border, borderColor, groupIcons, groupNames, paletteIcon
from ../utils/colors import fg, fgBr, fgBd
import ../utils/seq


# TODO: make less reptitive
const fgList = [fgBr.wh, fgBr.rd, fgBr.gn, fgBr.yw, fgBr.bl, fgBr.ma, fgBr.cy, fgBr.bk]


func groups(nerdFont: bool): seq[string] =
  if not nerdFont:
    return @groupNames

  let groups = collect:
    for (icon, group) in zip(groupIcons, groupNames):
      icon & " " & group

  return groups


func palette(): string =
  const paletteIcons = collect:
    for i in fgList: i & paletteIcon & ansiResetCode

  return join(paletteIcons, " ")


func styleBorder(colorCode: string, width: int = 0): seq[string] =
  let
    sides = [
      border[3],  # left
      border[1],  # right
      border[4] & repeat(border[0], width + 2) & border[5],  # top
      border[7] & repeat(border[2], width + 2) & border[6]  # bottom
    ]

    coloredSides = collect:
      for i in sides: colorCode & i & ansiResetCode

  return coloredSides


func styledGroups*(nerdFont: bool): seq[string] =
  const
    palette = " " & palette()
    colors = [fgBd.rd, fgBd.yw, fgBd.cy, fgBd.gn, fgBd.bl, fgBd.ma, fgBd.yw]

  let
    groupList = groups(nerdFont)
    width = runeLen(longestItem(groupList))

    sides = styleBorder(borderColor, width)

    coloredGroups = collect:
      for (c, g) in zip(colors, groupList):
        sides[0] & " " & c & alignLeft(g, width) & ansiResetCode & " " & sides[1]

  return @[sides[2]] & coloredGroups & @[sides[3], palette]
