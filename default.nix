let
  _pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/9a91318fffec81ad009b73fd3b640d2541d87909.tar.gz";
    sha256 = "sha256:16j9il4a540ihz16dz8bzsxxqwiiyy1i2c1xvs5y7qm9s6v3dr4b";
  }) {
    config = {};
    overlays = [(self: super: {
      coreutils-patched = super.coreutils.overrideAttrs (oa: {
        patches = (oa.patches or []) ++ [
          (self.fetchpatch {
            url = "https://github.com/johanot/coreutils/pull/1.patch";
            sha256 = "sha256-JagCpc3f4Lm0HaL/QaOsPTUANdeJYbtwZt/4RttDAoE=";
          })
        ];
      });
    })];
  };
in
{ pkgs ? _pkgs, ... }:
{
  date = import ./images/date.nix { inherit pkgs; };
  date-patched = import ./images/date.nix { inherit pkgs; coreutils = pkgs.coreutils-patched; };
  inherit pkgs;
}
