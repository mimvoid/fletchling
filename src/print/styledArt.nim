## Defines ASCII art and applies ANSI codes for color.
## Maps the art as string sequences to distro names.

import std/[tables, strutils, terminal, sugar]
import ./monoArt
from ../utils/colors import fgBrBd


func oneColor(artSeq: string, color: string): seq[string] =
  return collect:
    for i in splitLines(artSeq): color & i & ansiResetCode


const
  archArt = oneColor(monoArt.archArt, fgBrBd.bl)
  debianArt = oneColor(monoArt.debianArt, fgBrBd.rd)


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
  "arch": archArt,
  "debian": debianArt,
  "nixos": nixosArt()
}.toTable
