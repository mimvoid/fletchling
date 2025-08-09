import std/unittest
from ../src/utils/seq import longestItem, maxLen

suite "functions in src/utils":
  test "longestItem: empty array":
    const emptyArray: array[0, string] = []
    check(longestItem(emptyArray) == "")

  test "longestItem: singleton array":
    check(longestItem(["test"]) == "test")

  test "longestItem: three array items of different lengths":
    check(longestItem(["ant", "apple", "io"]) == "apple")

  test "longestItem: two items tied in length":
    check(longestItem(["ant", "tree", "pelt"]) == "tree")

  test "maxLen: empty array":
    const emptyArray: array[0, string] = []
    check(maxLen(emptyArray) == 0)

  test "maxLen: singleton array":
    check(maxLen(["test"]) == 4)

  test "maxLen: three array items of different lengths":
    check(maxLen(["ant", "apple", "io"]) == 5)

  test "maxLen: two items tied in length":
    check(maxLen(["ant", "tree", "pelt"]) == 4)

  test "maxLen: array of only empty strings":
    check(maxLen(["", "", ""]) == 0)
