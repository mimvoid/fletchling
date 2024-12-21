from std/sugar import collect
from std/sequtils import zip
from std/unicode import alignLeft, runeLen
from std/strformat import fmt
from std/strutils import repeat, join

import std/terminal

from ../utils/colors import fg, fgBr, fgBd
import ../utils/seq


const
  fgList = [fgBr.wh, fgBr.rd, fgBr.gn, fgBr.yw, fgBr.bl, fgBr.ma, fgBr.cy, fgBr.bk]
  border = ["─", "│", "─", "│", "╭", "╮", "╯", "╰"]


func categories(nerdFont: bool): seq[string] =
  const
    icons = ["", "󰌽", "", "", "", "󰥔", "󰏔"]
    names = ["user", "os", "kernel", "desktop", "shell", "uptime", "pkgs"]

  if not nerdFont:
    return @names

  let groups = collect:
    for i in zip(icons, names): i[0] & " " & i[1]

  return groups


func palette(): string =
  const
    icon = ""

    paletteIcons = collect:
      for i in fgList: i & icon & ansiResetCode

  return join(paletteIcons, " ")


func styledCategories*(nerdFont: bool): seq[string] =
  const
    palette = " " & palette()
    colors = [fgBd.rd, fgBd.yw, fgBd.cy, fgBd.gn, fgBd.bl, fgBd.ma, fgBd.yw]

  let
    colBorder = collect:
      for i in border: fg.cy & i & ansiResetCode

    cats = categories(nerdFont)
    width = runeLen(longestItem(cats))

    topBorder = fg.cy & border[4] & repeat(border[0], width + 2) & border[5] & ansiResetCode
    bottomBorder = fg.cy & border[7] & repeat(border[2], width + 2) & border[6] & ansiResetCode

    coloredCats = collect:
      for i in zip(colors, cats):
        fmt"{colBorder[1]} {i[0]}{alignLeft(i[1], width)}{ansiResetCode} {colBorder[3]}"

  return @[topBorder] & coloredCats & @[bottomBorder, palette]
