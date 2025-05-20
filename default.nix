let
  _pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/9b5ac7ad45298d58640540d0323ca217f32a6762.tar.gz";
    sha256 = "sha256:0zqvvkb1gsqxvm2vvp184spm1kc363sx0byv7cdxmmj4wk51kfv1";
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

  genericImage = name: { inherit name; config.EntryPoint = [ "${_pkgs.${name}}/bin/${name}" ]; };
in
{ pkgs ? _pkgs, ... }:
{
  cowsay = genericImage "cowsay";
  date = import ./images/date.nix { inherit pkgs; };
  date-patched = import ./images/date.nix { inherit pkgs; coreutils = pkgs.coreutils-patched; };
  inherit pkgs;
}
