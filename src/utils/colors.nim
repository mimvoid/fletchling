## Helpers for styling

import std/terminal


type
  Colors = tuple
    ## ANSI colors: red, green, yellow, blue, magenta, cyan, white, black
    wh, rd, gn, yw, bl, ma, cy, bk: string


func ansiColor(fg = fgDefault, bright = false, bold = false): string =
  ## Returns the ANSI codes to reset styling and apply foreground color
  ## Optionally adds a bold style code

  var coloredStr = ansiResetCode
  if bold:
    coloredStr.add(ansiStyleCode(styleBright))

  coloredStr.add(ansiForegroundColorCode(fg, bright))
  return coloredStr


func colorList(bright = false, bold = false): Colors =
  func makeColor(fg: ForegroundColor): string =
    return ansiColor(fg, bright, bold)

  return (
    wh: makeColor(fgWhite),
    rd: makeColor(fgRed),
    gn: makeColor(fgGreen),
    yw: makeColor(fgYellow),
    bl: makeColor(fgBlue),
    ma: makeColor(fgMagenta),
    cy: makeColor(fgCyan),
    bk: makeColor(fgBlack)
  )


const
  fg* = static: colorList()
  fgBd* = static: colorList(bold = true)
  fgBr* = static: colorList(bright = true)
  fgBrBd* = static: colorList(bright = true, bold = true)
