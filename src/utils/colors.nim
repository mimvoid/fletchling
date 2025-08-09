## Helpers for styling

import std/terminal


type
  Colors = tuple
    ## ANSI colors: red, green, yellow, blue, magenta, cyan, white, black
    wh, rd, gn, yw, bl, ma, cy, bk: string


func ansiColor(fg = fgDefault, bright = false, bold = false): string =
  ## Returns the ANSI codes to reset styling and apply foreground color
  ## Optionally adds a bold style code

  let fgCode = ansiForegroundColorCode(fg, bright)

  if bold:
    return ansiResetCode & ansiStyleCode(styleBright) & fgCode

  return ansiResetCode & fgCode


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
  fg* = colorList()
  fgBd* = colorList(bold = true)
  fgBr* = colorList(bright = true)
  fgBrBd* = colorList(bright = true, bold = true)
