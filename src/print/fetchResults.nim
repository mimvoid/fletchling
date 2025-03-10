import
  ../fetches/[
    getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages
  ]


func processName(username: string, hostname: string): string =
  if hostname == "":
    return username

  if username == "":
    return "@" & hostname

  return username & "@" & hostname


func processDistro(distro: string, version: string): string =
  if distro == "":
    return version

  if version == "":
    return distro

  return distro & " " & version


proc fetchResults*(): array[10, string] =
  let (distro, version) = getDistro()

  # Empty strings as padding to align with the group names and palette
  return [
    "",
    processName(getUsername(), getHostname()),
    processDistro(distro, version),
    getKernel(),
    getDesktop(),
    getShell(),
    getUptime(),
    getPackages(distro),
    "",
    ""
  ]
