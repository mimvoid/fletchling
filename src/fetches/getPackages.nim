## Fetches the package count of the distro's main package manager

import ../utils/fetch

const findPkgManager =
  hostOS notin ["macosx", "freebsd", "openbsd", "netbsd", "windows"]


when findPkgManager:
  from std/strutils import split
  import std/tables

  func mapPkgCmd(): Table[string, string] =
    const
      apk = "apk info | wc -l"
      dpkg = "dpkg -l | grep -c '^ii'"
      kiss = "kiss list | wc -l"
      nix = "nix-store -q --requisites ~/.nix-profile | wc -l"
      pacman = "pacman -Qq | wc -l"
      pmm = "/bedrock/libexec/pmm pacman pmm -Q | wc -l"
      portage = "qlist -I | wc -l"
      rpm = "rpm -qa | wc -l"
      slack = "ls /var/log/packages -1 | wc -l"
      xbps = "xbps-query -l | wc -l"
      zypper = "zypper se -i | wc -l"

    var t = {
      "bedrock": pmm,
      "gentoo": portage,
      "kiss": kiss,
      "nixos": nix,
      "slack": slack,
      "void": xbps
    }.toTable

    for i in ["alpine", "postmarket"]:
      t[i] = apk

    for i in ["android", "astra", "debian", "elementary", "linuxmint",
      "mxlinux", "ubuntu", "zorin", "kali"]:
      t[i] = dpkg

    for i in ["arch", "archcraft", "artix", "endeavouros", "manjaro",
      "garuda", "parabola"]:
      t[i] = pacman

    for i in ["fedora", "rhel", "centos", "redhat", "qubes"]:
      t[i] = rpm

    for i in ["suse", "opensuse", "opensuse-tumbleweed", "opensuse-leap"]:
      t[i] = zypper

    return t


  const pkgCommands = static: mapPkgCmd()


proc getPackages*(distroIdLike: string): string =
  when findPkgManager:
    for id in distroIdLike.split(' '):
      let cmd = pkgCommands.getOrDefault(id)
      if cmd != "":
        return getCommandOutput(cmd)

  # Handle OS-specific main package managers
  elif hostOS == "macosx":
    return getCommandOutput("brew list | wc -l")

  elif hostOS in ["freebsd", "openbsd", "netbsd"]:
    return getCommandOutput("pkg info -a | wc -l")

  elif hostOS == "windows":
    if distro.contains("msys2"):
      const pacman = "pacman -Qq | wc -l"
      return getCommandOutput(pacman)

  elif hostOS == "haiku":
    return getCommandOutput("pkgman search -ia | awk 'FNR > 2 { print }' | wc -l")
