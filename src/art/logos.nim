import std/strtabs
import ../fetches/getDistro


const
  nixosArt* = r"""
     \\    \\  //
      \\    \\//
  ::::://====\\  //
     ///      \\//
""'"//\\      ///"'""
   //  \\====//:::::
      //\\    \\
     //  \\    \\
"""


var t = {
  "nixos": nixosArt
}.newStringTable


proc getDistroArt*(): string =
  let distro = getDistro().name

  if distro in t:
    return t[distro]

  return ""
