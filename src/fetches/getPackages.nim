from std/strutils import contains
import std/strtabs

import
  ./getDistro,
  ../utils/fetch


func matchPkgCmd(): StringTableRef =
  let
    apk = "apk info 2>/dev/null | wc -l"
    dpkg = "dpkg -l 2>/dev/null | grep -c \"^ii\""
    pacman = "pacman -Qq 2>/dev/null | wc -l"
    rpm = "rpm -qa 2>/dev/null | wc -l"
    emerge = "find /var/db/pkg -mindepth 2 -maxdepth 2 2>/dev/null | wc -l"
    pkgman = "pkgman search -ia  2>/dev/null | awk 'FNR > 2 { print }' | wc -l"
    nix = "nix-store -q --requisites ~/.nix-profile 2>/dev/null | wc -l"
    slack = "find /var/log/packages -mindepth 1 -maxdepth 1 2>/dev/null | wc -l"
    xbps = "xbps-query -l 2>/dev/null | wc -l"

  var t = {
    "gentoo": emerge,
    "haiku": pkgman,
    "nixos": nix,
    "slack": slack,
    "void": xbps
  }.newStringTable

  for i in ["alpine", "postm"]:
    t[i] = apk

  for i in ["android", "astra", "bian", "elementary", "mint", "mx", "ubuntu",
      "zorin", "kali"]:
    t[i] = dpkg

  for i in ["arc", "artix", "endeavor", "manjaro", "garuda", "msys2", "parabola"]:
    t[i] = pacman

  for i in ["fedora", "qubes", "cent", "redhat", "opensuse"]:
    t[i] = rpm

  return t


proc getPackages*(): string =
  let
    distro = getDistro().name
    t = matchPkgCmd()

  for k, v in t:
    if not distro.contains(k): continue
    return getCmdResult(v)

  return ""
