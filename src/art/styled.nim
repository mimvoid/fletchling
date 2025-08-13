## Defines ASCII art and applies ANSI codes for color.
## Maps the art as string sequences to distro names.

import std/[tables, strutils, terminal, sugar]
from ../utils/colors import fgBd, fgBrBd
import ./mono


func oneColor(artSeq: seq[string], color: string): seq[string] =
  return collect:
    for i in artSeq: color & i & ansiResetCode


const
  archArt = static: oneColor(mono.art["arch"], fgBrBd.bl)
  artixArt = static: oneColor(mono.art["artix"], fgBrBd.bl)
  archcraftArt = static: oneColor(mono.art["archcraft"], fgBrBd.gn)
  arcolinuxArt = static: oneColor(mono.art["arcolinux"], fgBrBd.bl)
  cachyArt = static: oneColor(mono.art["cachyos"], fgBrBd.gn)
  debianArt = static: oneColor(mono.art["debian"], fgBrBd.rd)
  manjaroArt = static: oneColor(mono.art["manjaro"], fgBrBd.gn)
  nobaraArt = static: oneColor(mono.art["nobara"], fgBrBd.wh)
  opensuseArt = static: oneColor(mono.art["opensuse-leap"], fgBrBd.gn)

  # by: mimvoid
  bazziteArt = """
$1 .---$3-$1-------.   $5
$1'   $3|$4_$3|$1       "  $5
$1|$3__$4_: :_$3____$2   " $5
$3|_$4(_   _)$3__ '.$2  :$5
$1|   $4|_|$3    ; :$2  |$5
$1|   $3| `___"  ;$2  ;$5
$1'   $3'._____."$2  . $5
$1 "$2.          ."  $5
$2   '--------'    $5""".format(fgBrBd.bl, fgBrBd.ma, fgBd.wh,
      fgBrBd.wh, ansiResetCode).splitLines()


  # by: mimvoid
  centosArt = static: """
$1        .        $5
$1       / \       $5
$2  .- ---$1|$3--- -.  $5
$2  |/.   $1|$3   .\|  $5
$3 ,$2.  ". $1|$3 ."  .$4. $5
$3< |====[ ]$4====| >$5
$3 `$4|   ."$2|$1".   |$4' $5
$4  ' ."  $2|$1  ". '  $5
$4  |\____$2|$1____/|  $5
$2       \ /       $5
$2        '""".format(fgBrBd.yw, fgBrBd.gn, fgBrBd.ma, fgBrBd.bl,
      ansiResetCode).splitLines()

  # by: mimvoid
  endeavourArt = static: """
$1         .$2'\$3.       $4
$1       ."$2/  \$3".     $4
$1      ' $2"    "$3 '.   $4
$1    .' $2/      "$3  .  $4
$1   "   $2        '$3  \ $4
$1 ,"   $2"         |$3  .$4
$1.___ $2/        _-$3   :$4
    $3/$2"'""''""'$3   _. $4
    $3---------"'"'   $4""".format(fgBrBd.yw, fgBrBd.ma, fgBrBd.bl,
      ansiResetCode).splitLines()

  # by: mimvoid
  fedoraArt = static: """
$1   ..-------.    $3
$1 ."    $2.---.$1 ".  $3
$1.     $2:  _  `$1  " $3
$1|     $2: ; :_;$1   '$3
$1|  $2.--| |---.$1   |$3
$1| $2: ,-; |---"$1   ;$3
$1| $2| '"  ;$1      , $3
$1|  $2"___"$1      ,  $3
$1 "__________"'   $3""".format(fgBrBd.bl, fgBrBd.wh, ansiResetCode).splitLines()

  # by: mimvoid
  garudaArt = static: """
$1     _____$2______   $3
$1    / ___$2______ \  $3
$1   / / .$2       \ \ $3
$1  / / /'$2--------  \$3
$1 / /  -$2----------./$3
$1/ /  _$2_________  ' $3
$1\ \ /_$2______  /    $3
$1 \ \_$2______/ /     $3
$1  \_$2________/      $3""".format(fgBrBd.ma, fgBrBd.bl,
      ansiResetCode).splitLines()

  # by: mimvoid
  linuxArt = static: """
$1      __     $4
$1    '    "   $4
$1   : $2^$3__$2^$1 !  $4
$1   .$3<___"$1 .  $4
$1  / $2.$1    . \ $4
$1 ( $2'$1     /  )$4
$3.--.     .--,$4
$3\ __)$2---$3(__ /$4""".format(fgBrBd.bk, fgBrBd.wh, fgBrBd.yw,
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

  # by: mimvoid
  rhelArt = """
$1      -_---._      $3
$1     /       \     $3
$1    /         \    $3
$1  _$2/"._        $1\   $3
$1." $2"-_ "'-----",$1-. $3
$1'      $2"'""'""'$1   )$3
$1 "-._           _,'$3
$1     '""'""'""''   $3""".format(fgBrBd.rd, fgBrBd.bk,
      ansiResetCode).splitLines()

  # by: mimvoid
  ubuntuArt = """
$3             __ $4
$2     .-----.$3|  |$4
$1   ."\$2\      $3-- $4
$2 __$1   \$2`--_    \$4
$2|  |$1 "     $2"___"$4
$2 --$1  \     $3,---.$4
$1  \   `$3___'    ;$4
$1   . /$3/     $1__$3. $4
$1    "$3._____$1|  | $4
$1            $1--  $4""".format(fgBrBd.yw, fgBrBd.rd, fgBd.rd,
      ansiResetCode).splitLines()


const art* = static: {
  "arch": archArt,
  "archcraft": archcraftArt,
  "arcolinux": arcolinuxArt,
  "artix": artixArt,
  "bazzite": bazziteArt,
  "cachyos": cachyArt,
  "centos": centosArt,
  "debian": debianArt,
  "endeavouros": endeavourArt,
  "fedora": fedoraArt,
  "garuda": garudaArt,
  "linux": linuxArt,
  "manjaro": manjaroArt,
  "nixos": nixosArt,
  "nobara": nobaraArt,
  "opensuse-leap": opensuseArt,
  "opensuse-tumbleweed": opensuseArt,
  "rhel": rhelArt,
  "ubuntu": ubuntuArt
}.toTable
