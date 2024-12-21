import std/terminal


func col(
  fg: ForegroundColor = fgDefault, bright: bool = false, bold: bool = false
): string =
  let fore = ansiForegroundColorCode(fg, bright)

  if bold:
    return ansiResetCode & ansiStyleCode(styleBright) & fore

  return ansiResetCode & fore


# ANSI colors: red, green, yellow, blue, magenta, cyan, white, black
type
  Colors = tuple
    rd, gn, yw, bl, ma, cy, wh, bk: string


func colorList(bright: bool = false, bold: bool = false): Colors =
  return (
    rd: col(fgRed, bright, bold),
    gn: col(fgGreen, bright, bold),
    yw: col(fgYellow, bright, bold),
    bl: col(fgBlue, bright, bold),
    ma: col(fgMagenta, bright, bold),
    cy: col(fgCyan, bright, bold),
    wh: col(fgWhite, bright, bold),
    bk: col(fgBlack, bright, bold)
  )


const
  fg* = colorList()
  fgBd* = colorList(bold = true)
  fgBr* = colorList(bright = true)
  fgBrBd* = colorList(bright = true, bold = true)
