## Fetches the package count of the distro's main package manager

from std/strutils import contains, splitLines
import std/distros

import ../utils/fetch


proc countCmdLines(cmd: string): int {.inline.} =
  let cmdResult = getCommandOutput(cmd)
  return len(splitLines(cmdResult))


proc getPackages*(distro: string): string =
  # Handle OS-specific main package managers
  when hostOS == "macosx":
    return $countCmdLines("brew list")

  elif hostOS in ["freebsd", "openbsd", "netbsd"]:
    return $countCmdLines("pkg info -a")

  elif hostOS == "windows":
    if distro.contains("msys2"):
      return $countCmdLines(pacman)

  elif hostOS == "haiku":
    return $countCmdLines("pkgman search -ia | awk 'FNR > 2 { print }'")

  else:
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

    proc getDistroPkgs(): string {.inline.} =
      if detectOs(Ubuntu) or
          detectOs(Debian) or
          detectOs(Elementary) or
          detectOs(Kali) or
          detectOs(Zorin) or
          detectOs(MXLinux) or
          detectOs(Androidx86):
        return $countCmdLines(dpkg)

      if detectOs(ArchLinux) or
          detectOs(Artix) or
          detectOs(Manjaro) or
          detectOs(Parabola):
        return $countCmdLines(pacman)

      if detectOs(Fedora) or detectOs(RedHat) or
          detectOs(CentOS) or detectOs(Qubes):
        return $countCmdLines(rpm)

      if detectOs(NixOS):
        return $countCmdLines(nix)

      if detectOs(OpenSUSE):
        return $countCmdLines(zypper)

      if detectOs(Void):
        return $countCmdLines(xbps)

      if detectOs(Gentoo):
        return $countCmdLines(emerge)

      if detectOs(Alpine):
        return $countCmdLines(apk)

      if detectOs(Slackware):
        return $countCmdLines(slack)


    if distro == "bedrock":
      return $countCmdLines(pmm)
    if distro == "kiss":
      return $countCmdLines(kiss)

    return getDistroPkgs()
