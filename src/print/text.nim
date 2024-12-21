from std/sugar import collect
from std/sequtils import zip
from std/unicode import alignLeft, runeLen
from std/strformat import fmt
from std/strutils import repeat, join

import std/terminal

import
  ../config/vars,
  ../utils/style


const
  cyan = col(fgCyan)
  bRed = col(fgRed, bold = true)
  bGreen = col(fgGreen, bold = true)
  bYellow = col(fgYellow, bold = true)
  bCyan = col(fgCyan, bold = true)
  bBlue = col(fgBlue, bold = true)
  bMagenta = col(fgMagenta, bold = true)


proc categories(): seq[string] =
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
      for i in [fgWhite, fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan, fgBlack]:
        ansiResetCode & col(i, bright = true) & icon & ansiResetCode

  return join(paletteIcons, " ")


proc styledCategories*(): seq[string] =
  const
    colors = [bRed, bYellow, bCyan, bGreen, bBlue, bMagenta, bYellow]
    border = ["─", "│", "─", "│", "╭", "╮", "╯", "╰"]
    palette = " " & palette()

  let
    colBorder = collect:
      for i in border: cyan & i & ansiResetCode

    cats = categories()
    width = runeLen(longestItem(cats))

    topBorder = cyan & border[4] & repeat(border[0], width + 2) & border[5] & ansiResetCode
    bottomBorder = cyan & border[7] & repeat(border[2], width + 2) & border[6] & ansiResetCode

    coloredCats = collect(newSeq):
      for i in zip(colors, cats):
        fmt"{colBorder[1]} {i[0]}{alignLeft(i[1], width)}{ansiResetCode} {colBorder[3]}"

  return @[topBorder] & coloredCats & @[bottomBorder, palette]
