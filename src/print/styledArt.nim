## Defines ASCII art and applies ANSI codes for color.
## Maps the art as string sequences to distro names.

import std/[tables, strutils, terminal, sugar]
from ../utils/colors import fgBrBd


func nixosArt(): seq[string] =
  const
    # by: q60 (from disfetch)
    art = """
$1     $1\\    $2\\  //    $3
$1      \\    $2\\//     $3
$1  ::::://====$2\\  $1//  $3
$2     ///      \\$1//   $3
$2""'"//$1\\      ///"'""$3
$2   //  $1\\$2====//::::: $3
$1      //\\    $2\\     $3
$1     //  \\    $2\\    $3"""

    blue = fgBrBd.bl
    cyan = fgBrBd.cy

    l = collect:
      for i in splitLines(art): i % [blue, cyan, ansiResetCode]

  return l


let art* = {
  "nixos": nixosArt()
}.toTable
