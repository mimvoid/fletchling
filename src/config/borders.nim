type
  BorderChars* = tuple
    top, right, bottom, left, topLeft, topRight, bottomRight, bottomLeft: string

  BorderSides* = tuple
    left, right, top, bottom: string

  Border* = enum
    single, bold, double, rounded


const
  singleBorder*: BorderChars = ("─", "│", "─", "│", "┌", "┐", "┘", "└")
  boldBorder*: BorderChars = ("━", "┃", "━", "┃", "┏", "┓", "┛", "┗")
  doubleBorder*: BorderChars = ("═", "║", "═", "║", "╔", "╗", "╝", "╚")
  roundedBorder*: BorderChars = ("─", "│", "─", "│", "╭", "╮", "╯", "╰")


func getBorderChars*(enumValue: Border): BorderChars =
  case enumValue:
  of single: return singleBorder
  of bold: return boldBorder
  of double: return doubleBorder
  of rounded: return roundedBorder
