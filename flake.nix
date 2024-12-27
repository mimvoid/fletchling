{
  description = "Flake for fletchling";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      allSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;

      toSystems = passPkgs: allSystems (system:
        passPkgs (import nixpkgs { inherit system; })
      );
    in
    {
      packages = toSystems (pkgs: {
        default = pkgs.callPackage ./nix { };
      });

      overlay = final: prev: {
        fletchling = prev.pkgs.callPackage ./nix { };
      };

      devShells = toSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nim
            nimble
          ];
        };
      });
    };
}
