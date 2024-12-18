import
  ./fetches/[getNames, getDistro, getKernel, getDesktop, getShell, getUptime, getPackages],
  ./art/logos

echo getDistroArt()

stdout.write("user ")
echo getUsername(), "@", getHostname()

stdout.write("os ")
echo getDistro()

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
