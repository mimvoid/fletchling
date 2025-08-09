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

    ansiCodes = [fgBrBd.bk, fgBrBd.wh, fgBrBd.yw, ansiResetCode]

  return collect:
    for i in splitLines(art): i % ansiCodes


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

    ansiCodes = [fgBrBd.bl, fgBrBd.cy, ansiResetCode]

  return collect:
    for i in splitLines(art): i % ansiCodes


let art* = {
  "arch": archArt,
  "debian": debianArt,
  "linux": linuxArt(),
  "nixos": nixosArt()
}.toTable
