import std/[strtabs, strutils, terminal, sugar]

import ../fetches/getDistro


func col(fg: ForegroundColor, bright: bool, bold: bool): string =
  let foreground = ansiForegroundColorCode(fg, bright)

  if bold:
    return ansiResetCode & ansiStyleCode(styleBright) & foreground

  return ansiResetCode & foreground


func ws(num: Natural): string =
  return ansiResetCode & spaces(num) & ansiResetCode


func nixosArt(): string =
  #[
         \\    \\  //
          \\    \\//
      ::::://====\\  //
         ///      \\//
    ""'"//\\      ///"'""
       //  \\====//:::::
          //\\    \\
         //  \\    \\
  ]#

  const
    art = r"""
$1     $1\\    $2\\  //    $3
$1      \\    $2\\//     $3
$1  ::::://====$2\\  $1//  $3
$2     ///      \\$1//   $3
$2""'"//$1\\      ///"'""$3
$2   //  $1\\$2====//::::: $3
$1      //\\    $2\\     $3
$1     //  \\    $2\\    $3
"""

    blue = col(fgBlue, bright = true, bold = true)
    cyan = col(fgCyan, bright = true, bold = true)

    l = collect(newSeq):
      for i in splitLines(art): i % [blue, cyan, ansiResetCode]

  return join(l, "\n")


var t = {
  "nixos": nixosArt()
}.newStringTable


proc getDistroArt*(): string =
  let distro = getDistro().name

  if distro in t:
    return t[distro]

  return ""
