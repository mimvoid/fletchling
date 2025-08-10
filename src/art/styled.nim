## Defines ASCII art and applies ANSI codes for color.
## Maps the art as string sequences to distro names.

import std/[tables, strutils, terminal, sugar]
from ../utils/colors import fgBrBd
import ./mono


func oneColor(artSeq: seq[string], color: string): seq[string] =
  return collect:
    for i in artSeq: color & i & ansiResetCode


const
  archArt = static: oneColor(mono.art["arch"], fgBrBd.bl)
  debianArt = static: oneColor(mono.art["debian"], fgBrBd.rd)

  # by: mimvoid
  linuxArt = static: """
$1        __     $4
$1      '    "   $4
$1     : $2^$3__$2^$1 !  $4
$1     .$3<___"$1 .  $4
$1    / $2.$1    . \ $4
$1   ( $2'$1     /  )$4
$3  .--.     .--,$4
$3  \ __)$2---$3(__ /$4""".format(fgBrBd.bk, fgBrBd.wh, fgBrBd.yw,
      ansiResetCode).splitLines()

  # by: q60 (from disfetch)
  nixosArt = static: """
$1     $1\\    $2\\  //    $3
$1      \\    $2\\//     $3
$1  ::::://====$2\\  $1//  $3
$2     ///      \\$1//   $3
$2""'"//$1\\      ///"'""$3
$2   //  $1\\$2====//::::: $3
$1      //\\    $2\\     $3
$1     //  \\    $2\\    $3""".format(fgBrBd.bl, fgBrBd.cy,
      ansiResetCode).splitLines()


const art* = static: {
  "arch": archArt,
  "debian": debianArt,
  "linux": linuxArt,
  "nixos": nixosArt
}.toTable
