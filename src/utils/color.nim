import std/[strutils, terminal]


func col*(fg: ForegroundColor, bright: bool, bold: bool): string =
  let foreground = ansiForegroundColorCode(fg, bright)

  if bold:
    return ansiResetCode & ansiStyleCode(styleBright) & foreground

  return ansiResetCode & foreground


func ws*(num: Natural): string =
  return ansiResetCode & spaces(num) & ansiResetCode
