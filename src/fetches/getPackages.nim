## Fetches the package count of the distro's main package manager

from std/strutils import contains, splitLines
import std/strtabs

import ../utils/fetch


const
  apk = "apk info"
  dpkg = r"dpkg-query -f '.\n' -W"
  emerge = "qlist -I"
  kiss = "kiss list"
  nix = "nix-store -q --requisites ~/.nix-profile"
  pacman = "pacman -Qq"
  pmm = "/bedrock/libexec/pmm pacman pmm -Q"
  rpm = "rpm -qa"
  slack = "ls /var/log/packages"
  xbps = "xbps-query -l"
  zypper = "zypper se"


func mapPkgCmd(): StringTableRef =
  let t = {
    "bedrock": pmm,
    "gentoo": emerge,
    "kiss": kiss,
    "nixos": nix,
    "opensuse": zypper,
    "slack": slack,
    "void": xbps
  }.newStringTable

  for i in ["alpine", "postm"]:
    t[i] = apk

  for i in [
    "android", "astra", "bian", "elementary", "mint", "mx", "ubuntu", "zorin", "kali"
  ]:
    t[i] = dpkg

  for i in ["arc", "artix", "endeavor", "manjaro", "garuda", "parabola"]:
    t[i] = pacman

  for i in ["fedora", "cent", "redhat", "qubes"]:
    t[i] = rpm

  return t


func matchPkgCmd(distro: string, t: StringTableRef): string =
  # Skip the substring matching if it isn't needed
  if t.hasKey(distro):
    return t[distro]

  for k, v in t:
    if distro.contains(k):
      return v

  return ""


proc countCmdLines(cmd: string): int =
  let cmdResult = getCmdResult(cmd)
  return len(splitLines(cmdResult))


proc getPackages*(distro: string): string =
  const os = system.hostOS
  let t = mapPkgCmd()

  # Handle OS-specific main package managers
  when os == "macosx":
    return $countCmdLines("brew list")

  elif os in ["freebsd", "openbsd", "netbsd"]:
    return $countCmdLines("pkg info -a")

  elif os == "windows":
    if distro.contains("msys2"):
      return $countCmdLines(pacman)
    return ""

  elif os == "haiku":
    return $countCmdLines("pkgman search -ia | awk 'FNR > 2 { print }'")

  # Match the distro to its main package manager
  else:
    let cmd = matchPkgCmd(distro, t)

    if cmd == "":
      return ""

    return $countCmdLines(cmd)
