import std/parseopt

proc getArgs*() =
  for kind, key, val in getopt():
    case kind:
    of cmdArgument: discard
    of cmdLongOption, cmdShortOption: discard
    of cmdEnd:
      discard
