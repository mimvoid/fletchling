func longestItem*[T](lst: openArray[T]): T =
  ## A simple function that iterates over an array and
  ## returns the longest item
  ##
  ## In case of a tie, returns the first found.
  ##
  ## Note: This doesn't work well with `runes`.

  var longest: T

  for i in lst:
    if len(i) > len(longest):
      longest = i

  return longest
