from std/sugar import collect
from std/sequtils import zip
from std/unicode import alignLeft, runeLen
from std/strformat import fmt
from std/strutils import repeat, join

import std/terminal

from ./elems import border, borderColor, groupIcons, groupNames, paletteIcon
from ../utils/colors import fg, fgBr, fgBd
import ../utils/seq


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


func styleBorder(colorCode: string, side: string, width: int = 0): string =
  let text =
    if side == "left":
      border[3]
    elif side == "right":
      border[1]
    elif side == "top":
      border[4] & repeat(border[0], width + 2) & border[5]
    elif side == "bottom":
      border[7] & repeat(border[2], width + 2) & border[6]
    else:
      raise newException(ValueError, "Not a valid side value")

  return borderColor & text & ansiResetCode


func styledGroups*(nerdFont: bool): seq[string] =
  const
    palette = " " & palette()
    colors = [fgBd.rd, fgBd.yw, fgBd.cy, fgBd.gn, fgBd.bl, fgBd.ma, fgBd.yw]

    borderLeft = styleBorder(borderColor, "left")
    borderRight = styleBorder(borderColor, "right")

  let
    groupList = groups(nerdFont)
    width = runeLen(longestItem(groupList))

    borderTop = styleBorder(borderColor, "top", width)
    borderBottom = styleBorder(borderColor, "bottom", width)

    coloredGroups = collect:
      for (c, g) in zip(colors, groupList):
        borderLeft & " " & c & alignLeft(g, width) & ansiResetCode & " " & borderRight

  return @[borderTop] & coloredGroups & @[borderBottom, palette]
