{
  lib,
  nimPackages,
  fetchFromGitHub,
}:

nimPackages.buildNimPackage {
  pname = "fletchling";
  version = "unstable-2024-12-17";
  nimBinOnly = true;

  src = fetchFromGitHub {
    owner = "mimvoid";
    repo = "fletchling";
    rev = "";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # buildInputs = with nimPackages; [  ];

  meta = {
    description = "";
    homepage = "";
    licenses = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ mimvoid ];
  };
}
