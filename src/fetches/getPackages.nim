## Fetches the package count of the distro's main package manager

import ../utils/fetch

const findPkgManager =
  not (hostOS in ["macosx", "freebsd", "openbsd", "netbsd", "windows"])


when findPkgManager:
  from std/strutils import contains, splitLines
  import std/distros

  const
    apk = "apk info | wc -l"
    dpkg = "dpkg -l | grep -c '^ii'"
    kiss = "kiss list"
    nix = "nix-store -q --requisites ~/.nix-profile | wc -l"
    pacman = "pacman -Qq | wc -l"
    pmm = "/bedrock/libexec/pmm pacman pmm -Q"
    portage = "qlist -I | wc -l"
    rpm = "rpm -qa | wc -l"
    slack = "ls /var/log/packages | wc -l"
    xbps = "xbps-query -l | wc -l"
    zypper = "zypper se -i | wc -l"


  proc getPkgCommand(): string {.inline.} =
    if detectOs(Ubuntu) or
        detectOs(Debian) or
        detectOs(Elementary) or
        detectOs(Kali) or
        detectOs(Zorin) or
        detectOs(MXLinux) or
        detectOs(Androidx86):
      return dpkg

    if detectOs(ArchLinux) or
        detectOs(Artix) or
        detectOs(Manjaro) or
        detectOs(Parabola):
      return pacman

    if detectOs(Fedora) or detectOs(RedHat) or
        detectOs(CentOS) or detectOs(Qubes):
      return rpm

    if detectOs(NixOS): return nix
    if detectOs(OpenSUSE): return zypper
    if detectOs(Void): return xbps
    if detectOs(Gentoo): return portage
    if detectOs(Alpine): return apk
    if detectOs(Slackware): return slack


  proc countCmdLines(cmd: string): int {.inline.} =
    let cmdResult = getCommandOutput(cmd)
    return len(splitLines(cmdResult))


proc getPackages*(distro: string): string =
  when findPkgManager:
    # It might be possible to use "wc -l" with these too, but I'm not sure
    if distro == "bedrock":
      return $countCmdLines(pmm)
    if distro == "kiss":
      return $countCmdLines(kiss)

    let cmd = getPkgCommand()
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
