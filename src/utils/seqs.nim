func longestItem*[T](s: openArray[T]): T =
  ## A simple function that iterates over an array and
  ## returns the longest item
  ##
  ## In case of a tie, returns the first found.

  for i in s:
    if len(i) > len(result):
      result = i

func maxLen*[T](s: openArray[T]): int =
  ## Returns the length of the longest item in an array
  ##
  ## Note: This doesn't work well with `runes`.

  for i in s:
    if len(i) > result:
      result = len(i)
