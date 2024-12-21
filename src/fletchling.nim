import
  ./fetches/[
    getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages
  ],
  ./print/art


echo getDistroArt()

stdout.write("user ")
echo getUsername(), "@", getHostname()

stdout.write("os ")
echo getDistro().name, " ", getDistro().version

stdout.write("kernel ")
echo getKernel()

stdout.write("shell ")
echo getShell()

stdout.write("desktop ")
echo getDesktop()

stdout.write("uptime ")
echo getUptime()

stdout.write("packages ")
echo getPackages()
