from std/tables import toTable
from std/strutils import splitLines, alignLeft
from std/sugar import collect

from ../utils/style import longestItem


const
  nixosArt* = r"""
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
    artLines = splitLines(artStr)
    length = len(longestItem(artLines))

    aligned = collect:
      for i in artLines: alignLeft(i, length)

  return aligned


var art* = {
  "nixos": process(nixosArt)
}.toTable
