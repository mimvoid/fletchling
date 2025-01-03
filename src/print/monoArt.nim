## Defines ASCII art without styling.
## Maps the art as string sequences to distro names.

from std/tables import toTable
from std/strutils import splitLines, alignLeft
from std/sugar import collect

import ../utils/seq


const
  nixosArt* = """
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
    width = len(longestItem(lines))

    aligned = collect:
      for i in lines: alignLeft(i, width)

  return aligned


let art* = {
  "nixos": process(nixosArt)
}.toTable
