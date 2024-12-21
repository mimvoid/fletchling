import std/[tables, strutils, terminal, sugar]
from ../utils/style import col


const
  blue = col(fgBlue, bright = true, bold = true)
  cyan = col(fgCyan, bright = true, bold = true)


func nixosArt(): seq[string] =
  const
    art = r"""
$1     $1\\    $2\\  //    $3
$1      \\    $2\\//     $3
$1  ::::://====$2\\  $1//  $3
$2     ///      \\$1//   $3
$2""'"//$1\\      ///"'""$3
$2   //  $1\\$2====//::::: $3
$1      //\\    $2\\     $3
$1     //  \\    $2\\    $3"""

    l = collect:
      for i in splitLines(art): i % [blue, cyan, ansiResetCode]

  return l


var art* = {
  "nixos": nixosArt()
}.toTable
