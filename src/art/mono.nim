## Defines ASCII art without styling.
## Maps the art as string sequences to distro names.

from std/tables import toTable
from std/strutils import splitLines, alignLeft
from std/sugar import collect

from ../utils/seqs import maxLen


const
  # by: mimvoid
  archArt* = """
        .
       / \
      /   \
     ,\    \
    /       \
   /   .-.   \
  /   !   !  -.
 /  _.     ._  \
..-           -.."""

  # by: mimvoid
  archcraftArt = """
        .
       / \
      /   \
     ,\    \
    /   _   \
   /  _/ \_  \
  /  < .-. > -.
 /  _.>'-'<._  \
..-           -.."""

  # by: mimvoid
  arcolinuxArt* = """
        .
       / \
      /   \
     /  .  \
    /  / \  \
   /  /   \  \
  /  / ----'  \
 /  /   "'-.   \
'---        "---'"""

  # by: mimvoid
  artixArt = """
        .
       / \
      /   \
     '"._  \
    /-_  "-_\
   /   "-._
  /     _.-" _-
 /  _."   .-"  \
.-'         " -.."""

  # by: mimvoid
  cachyArt = """
   .----------
  /|\        /  []
 / | -------'.-.
/  |/        '-'
----            ..
\-. \          :  :
 \ "-\________. ''
  \ /         /
   ----------'"""

  # by: mimvoid
  debianArt* = """
    ""'""::.
  "'"      "".
 '"   .--.  :::
""   :    ,  ""
""    ._    ""
 "'      ""'`
  ""
    ".
      `` ."""

  # by: mimvoid
  endeavourArt = """
         .'\.
       ."/  \".
      ' "    " '.
    .' /      "  .
   "           '  \
 ,"   "         |  .
.___ /        _-   :
    /"'""''""'   _.
    ---------"'"'"""

  # by: mimvoid
  garudaArt = """
     ___________
    / _________ \
   / / .       \ \
  / / /'--------  \
 / /  -----------./
/ /  __________  '
\ \ /_______  /
 \ \_______/ /
  \_________/"""

  # by: mimvoid
  linuxArt = """
      __
    '    "
   : ^__^ !
   .<___" .
  / .    . \
 ( '     /  )
.--.     .--,
\ __)---(__ /"""

  # by: mimvoid
  manjaroArt = """
.---------. .---.
|         | |   |
|    _____! !   |
|   |  ___  |   |
|   | |   | |   |
|   | |   | |   |
|   | |   | |   |
|   | |   | |   |
'---' '---' '---'"""

  # by: q60 (from disfetch)
  nixosArt = """
     \\    \\  //
      \\    \\//
  ::::://====\\  //
     ///      \\//
""'"//\\      ///"'""
   //  \\====//:::::
      //\\    \\
     //  \\    \\"""


func process(artStr: string): seq[string] =
  ## Splits strings by line into sequences of strings.
  ## Adds trailing whitespace for text alignment.

  let
    lines = splitLines(artStr)
    width = maxLen(lines)

  return collect:
    for i in lines: alignLeft(i, width)


const art* = static: {
  "arch": process(archArt),
  "archcraft": process(archcraftArt),
  "arcolinux": process(arcolinuxArt),
  "artix": process(artixArt),
  "cachyos": process(cachyArt),
  "debian": process(debianArt),
  "endeavouros": process(endeavourArt),
  "garuda": process(garudaArt),
  "linux": process(linuxArt),
  "manjaro": process(manjaroArt),
  "nixos": process(nixosArt)
}.toTable
