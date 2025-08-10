## Formats, styles, and puts together `fletchling`'s text

from std/sugar import collect
from std/sequtils import zip
from std/unicode import alignLeft, runeLen
from std/strutils import repeat, join

import std/[terminal, options]

from ./elems import border, borderColor, groupIcons, groupNames
from ../utils/colors import fg, fgBr, fgBd
import ../utils/seqs


func groups(noNerdFont: bool): array[7, string] =
  ## If nerd fonts are enabled, returns strings of group names with icons.
  ## If not, only returns the group names.

  if noNerdFont:
    return groupNames

  var withIcons = groupIcons
  for i in 0..high(withIcons):
    withIcons[i] &= " " & groupNames[i]

  return withIcons


func palette(icon: string): string =
  ## Applies foreground colors to display on each copy of an icon.

  var paletteIcons = [
    fgBr.wh, fgBr.rd, fgBr.gn, fgBr.yw, fgBr.bl, fgBr.ma, fgBr.cy, fgBr.bk
  ]
  for i in 0..high(paletteIcons):
    paletteIcons[i] &= icon & ansiResetCode

  return join(paletteIcons, " ")


func makeBorder(colorCode: Option[string], width = 0): seq[string] =
  ## Returns a sequence of strings defining a border:
  ##
  ## The full top and bottom edge, and individual characters for
  ## the left and right edge.

  let
    sides = [
      border[3], # left
      border[1], # right
      border[4] & repeat(border[0], width + 2) & border[5], # top
      border[7] & repeat(border[2], width + 2) & border[6] # bottom
    ]

  if colorCode.isSome():
    let color = colorCode.get()
    return collect:
      for i in sides: color & i & ansiResetCode

  return @sides


func formatGroups*(paletteIcon: string, noFmt, noNerdFont: bool): seq[string] =
  ## Puts the group names, border, and palette together.

  let
    groupList = groups(noNerdFont)
    width = runeLen(longestItem(groupList))

  if noFmt:
    let sides = makeBorder(none(string), width)
    var groups = @[sides[2]]

    for g in groupList:
      groups.add(sides[0] & " " & alignLeft(g, width) & " " & sides[1])

    groups.add(sides[3])
    return groups

  let sides = makeBorder(some(borderColor), width)
  var groups = @[sides[2]]
  const colors = [fgBd.rd, fgBd.yw, fgBd.cy, fgBd.gn, fgBd.bl, fgBd.ma, fgBd.yw]

  for (c, g) in zip(colors, groupList):
    groups.add(sides[0] & " " & c & alignLeft(g, width) & ansiResetCode &
        " " & sides[1])

  groups.add([sides[3], " " & palette(paletteIcon)])
  return groups
