{
  lib,
  buildNimPackage,
}:

buildNimPackage rec {
  pname = "fletchling";
  version = "0.1.0";

  src = builtins.path {
    name = "${pname}-${version}";
    path = lib.cleanSource ../.;
  };

  nimFlags = [
    "-d:NimblePkgVersion=${version}"
    "--opt:speed"
  ];

  lockFile = ./lock.json;

  meta = {
    description = "fetcher written in Nim";
    homepage = "https://github.com/mimvoid/fletchling";
    licenses = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ mimvoid ];
    mainProgram = "fletchling";
  };
}
