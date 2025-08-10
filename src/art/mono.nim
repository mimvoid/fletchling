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
  linuxArt = """
        __
      '    "
     : ^__^ !
     .<___" .
    / .    . \
   ( '     /  )
  .--.     .--,
  \ __)---(__ /"""

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
  "debian": process(debianArt),
  "linux": process(linuxArt),
  "nixos": process(nixosArt)
}.toTable
