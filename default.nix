{ compiler ? "ghc8102" }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};

  ghcide = (import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {})."ghcide-${compiler}";

  gitignore = pkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];

  myHaskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = hself: hsuper: {
      "ghosts" =
        hself.callCabal2nix
          "ghosts"
          (gitignore ./.)
          {};
    };
  };

  shell = myHaskellPackages.shellFor {
    packages = p: [
      p."ghosts"
    ];
    buildInputs = [
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.ghcid
      pkgs.haskellPackages.ormolu
      pkgs.haskellPackages.hlint
      pkgs.niv
      pkgs.nixpkgs-fmt
      ghcide
    ];
    withHoogle = true;
  };

  exe = pkgs.haskell.lib.justStaticExecutables (myHaskellPackages."ghosts");

  docker = pkgs.dockerTools.buildImage {
    name = "ghosts";
    config.Cmd = [ "${exe}/bin/ghosts" ];
  };
in
{
  inherit shell;
  inherit exe;
  inherit docker;
  inherit myHaskellPackages;
  "ghosts" = myHaskellPackages."ghosts";
}
