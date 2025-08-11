import
  ../fetches/[
    getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages
  ]


func processName(username: string, hostname: string): string {.inline.} =
  if hostname == "":
    return username

  return username & '@' & hostname


func processDistro(distro: string, version: string): string {.inline.} =
  if distro == "":
    return version

  if version == "":
    return distro

  return distro & ' ' & version


proc fetchResults*(): tuple[values: array[10, string], distroid: string] =
  let (distro, id, idLike, version) = getDistro()

  # Empty strings as padding to align with the group names and palette
  return ([
    "",
    processName(getUsername(), getHostname()),
    processDistro(distro, version),
    getKernel(),
    getDesktop(),
    getShell(),
    getUptime(),
    getPackages(idLike),
    "",
    ""
  ], id)
