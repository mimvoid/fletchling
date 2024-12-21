import std/[terminal]
from std/strutils import spaces
from std/sequtils import repeat


func col*(fg: ForegroundColor, bright: bool = false,
    bold: bool = false): string =
  let foreground = ansiForegroundColorCode(fg, bright)

  if bold:
    return ansiResetCode & ansiStyleCode(styleBright) & foreground

  return ansiResetCode & foreground


func ws*(num: Natural): string =
  return ansiResetCode & spaces(num) & ansiResetCode


proc longestItem*[T](lst: openArray[T]): T =
  var longest: T

  for i in lst:
    if len(i) > len(longest):
      longest = i

  return longest


func seqPad*(length: int, sequence: seq[string]): seq[string] =
  let
    padLength = length - len(sequence)
    width = len(longestItem(sequence))

  return repeat(spaces(width), padLength)


func padColumns*(seqs: openArray[seq[string]]): seq[seq[string]] =
  let longest = longestItem(seqs)
  var paddedSeqs: seq[seq[string]]

  for i in seqs:
    if i != longest:
      paddedSeqs.add(i & seqPad(len(longest), i))
    else:
      paddedSeqs.add(longest)

  return paddedSeqs
