## Formats, styles, and puts together `fletchling`'s text

from std/sequtils import zip, apply
from std/unicode import alignLeft, runeLen
from std/strutils import repeat, join

import std/[terminal, options]

from ./elems import borderColor, groupIcons, groupNames
from ../utils/colors import fg, fgBr, fgBd
import ../config/borders
import ../utils/seqs


func groups(noNerdFont: bool): array[7, string] =
  ## If nerd fonts are enabled, returns strings of group names with icons.
  ## If not, only returns the group names.

  if noNerdFont:
    return groupNames

  var withIcons = groupIcons
  for i in 0..6:
    withIcons[i] &= ' ' & groupNames[i]

  return withIcons


func palette(icon: string): string =
  ## Applies foreground colors to display on each copy of an icon.

  const paletteIcons = [
    fgBr.wh, fgBr.rd, fgBr.gn, fgBr.yw, fgBr.bl, fgBr.ma, fgBr.cy, fgBr.bk, ansiResetCode
  ]
  return join(paletteIcons, ' ' & icon)


func makeBorder(
  kind: Border, colorCode: Option[string], width = 0
): BorderSides =
  ## Returns a sequence of strings defining a border:
  ##
  ## The full top and bottom edge, and individual characters for
  ## the left and right edge.

  let border = getBorderChars(kind)
  var sides: BorderSides = (
    border.left,
    border.right,
    border.topLeft & repeat(border.top, width + 2) & border.topRight,
    border.bottomLeft & repeat(border.bottom, width + 2) & border.bottomRight
  )

  if colorCode.isSome():
    let color = colorCode.get()
    sides.left = color & sides.left
    sides.right = color & sides.right
    sides.top = color & sides.top
    sides.bottom = color & sides.bottom

  return sides


func formatGroups*(
  borderKind: Border, paletteIcon: string, noFmt, noNerdFont: bool
): seq[string] =
  ## Puts the group names, border, and palette together.

  let
    groupList = groups(noNerdFont)
    width = runeLen(longestItem(groupList))

  if noFmt:
    let sides = makeBorder(borderKind, none(string), width)
    var groups = @[sides.top]

    for g in groupList:
      groups.add(join([sides.left, alignLeft(g, width), sides.right], " "))

    groups.add(sides.bottom)
    return groups

  let sides = makeBorder(borderKind, some(borderColor), width)
  var groups = @[sides.top]
  const colors = [fgBd.rd, fgBd.yw, fgBd.cy, fgBd.gn, fgBd.bl, fgBd.ma, fgBd.yw]

  for (c, g) in zip(colors, groupList):
    groups.add(
      join([sides.left, c & alignLeft(g, width), sides.right & ansiResetCode], " ")
    )

  groups.add([sides.bottom, palette(paletteIcon)])
  return groups
