from std/osproc import execCmdEx

proc getCmdResult*(cmd: string): string =
  let res = execCmdEx(cmd)

  # Check the exit code
  if res[1] == 0:
    return res[0]
  else:
    return ""
