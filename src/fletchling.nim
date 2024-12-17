import
  ./fetches/[getNames, getDistro, getDesktop, getShell]

stdout.write("user ")
echo getUsername(), "@", getHostname()

stdout.write("os ")
echo getDistro()

stdout.write("shell ")
echo getShell()

stdout.write("desktop ")
echo getDesktop()
