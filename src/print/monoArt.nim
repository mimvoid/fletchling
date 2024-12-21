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
  let
    lines = splitLines(artStr)
    width = len(longestItem(lines))

    aligned = collect:
      for i in lines: alignLeft(i, width)

  return aligned


let art* = {
  "nixos": process(nixosArt)
}.toTable
