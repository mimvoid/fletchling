func longestItem*[T](lst: openArray[T]): T =
  var longest: T

  for i in lst:
    if len(i) > len(longest):
      longest = i

  return longest
