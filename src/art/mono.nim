## Defines ASCII art without styling.
## Maps the art as string sequences to distro names.

from std/tables import toTable
from std/strutils import splitLines, alignLeft
from std/sugar import collect

from ../utils/seqs import maxLen


const
  # by: mimvoid
  archArt = """
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
  arcolinuxArt = """
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
  bazziteArt = """
 .-----------.
'   |_|       "
|___: :_____   "
|_(_   _)__ '.  :
|   |_|    ; :  |
|   | `___"  ;  ;
'   '._____."  .
 ".          ."
   '--------'"""

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
  centosArt = """
        .
       / \
  .- ---|--- -.
  |/.   |   .\|
 ,.  ". | ."  ..
< |====[ ]====| >
 `|   ."|".   |'
  ' ."  |  ". '
  |\____|____/|
       \ /
        '"""

  # by: mimvoid
  debianArt = """
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
  fedoraArt = """
   ..-------.
 ."    .---. ".
.     :  _  `  "
|     : ; :_;   '
|  .--| |---.   |
| : ,-; |---"   ;
| | '"  ;      ,
|  "___"      ,
 "__________"'"""

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

  # by: mimvoid
  nobaraArt = """
 __   ______
'  ".'      ".
|             .
|    .---.    |
|   : .-. >   |
|   . '-' |   |
|    "".  |   |
|   .-. \ |   |
`___'  \| `___'"""

  # by: mimvoid
  rhelArt = """
      -_---._
     /       \
    /         \
  _/"._        \
." "-_ "'-----",-.
'      "'""'""'   )
 "-._           _,'
     '""'""'""''"""


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
  "bazzite": process(bazziteArt),
  "cachyos": process(cachyArt),
  "centos": process(centosArt),
  "debian": process(debianArt),
  "endeavouros": process(endeavourArt),
  "fedora": process(fedoraArt),
  "garuda": process(garudaArt),
  "linux": process(linuxArt),
  "manjaro": process(manjaroArt),
  "nixos": process(nixosArt),
  "nobara": process(nobaraArt),
  "rhel": process(rhelArt)
}.toTable
