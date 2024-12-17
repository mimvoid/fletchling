import
  ./fetches/[getDistro, getDesktop, getShell]

stdout.write("os ")
echo getDistro()

stdout.write("shell ")
echo getShell()

stdout.write("desktop ")
echo getDesktop()
