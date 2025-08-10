from std/strutils import join
import std/tables


proc printArt*(art: Table[string, seq[string]]) =
  var printStr = ""

  for k, v in art.pairs:
    printStr.add(k & ":\n")
    printStr.add(join(v, "\n"))
    printStr.add("\n\n")

  echo(printStr)
