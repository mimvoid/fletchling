type
  BorderChars* = tuple
    top, right, bottom, left, topLeft, topRight, bottomRight, bottomLeft: string

  BorderSides* = tuple
    left, right, top, bottom: string

  Border* = enum
    none, single, bold, double, rounded


const
  noBorder*: BorderChars = static:
    (" ", "", " ", "", "", "", "", "")
  singleBorder*: BorderChars = static:
    ("─", "│", "─", "│", "┌", "┐", "┘", "└")
  boldBorder*: BorderChars = static:
    ("━", "┃", "━", "┃", "┏", "┓", "┛", "┗")
  doubleBorder*: BorderChars = static:
    ("═", "║", "═", "║", "╔", "╗", "╝", "╚")
  roundedBorder*: BorderChars = static:
    ("─", "│", "─", "│", "╭", "╮", "╯", "╰")


func getBorderChars*(enumValue: Border): BorderChars {.inline.} =
  case enumValue:
  of none: return noBorder
  of single: return singleBorder
  of bold: return boldBorder
  of double: return doubleBorder
  of rounded: return roundedBorder
