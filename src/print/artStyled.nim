## Defines ASCII art and applies ANSI codes for color.
## Maps the art as string sequences to distro names.

import std/[tables, strutils, terminal, sugar]
import ./artMono
from ../utils/colors import fgBrBd


func oneColor(artSeq: string, color: string): seq[string] =
  return collect:
    for i in splitLines(artSeq): color & i & ansiResetCode


const
  archArt = oneColor(artMono.archArt, fgBrBd.bl)
  debianArt = oneColor(artMono.debianArt, fgBrBd.rd)

func linuxArt(): seq[string] =
  const
    # by: mimvoid
    art = """
$1        __     $4
$1      '    "   $4
$1     : $2^$3__$2^$1 !  $4
$1     .$3<___"$1 .  $4
$1    / $2.$1    . \ $4
$1   ( $2'$2     /  )$4
$3  .--.     .--,$4
$3  \ __)$2---$3(__ /$4"""

    black = fgBrBd.bk
    white = fgBrBd.wh
    yellow = fgBrBd.yw

  return collect:
    for i in splitLines(art): i % [black, white, yellow, ansiResetCode]


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

  return collect:
    for i in splitLines(art): i % [blue, cyan, ansiResetCode]


let art* = {
  "arch": archArt,
  "debian": debianArt,
  "linux": linuxArt(),
  "nixos": nixosArt()
}.toTable
