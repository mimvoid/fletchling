import std/[strtabs, strutils, terminal, sugar]

import ../fetches/getDistro
from ../utils/color import col


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
