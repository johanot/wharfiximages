let
  _pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/9b5ac7ad45298d58640540d0323ca217f32a6762.tar.gz";
    sha256 = "sha256:0zqvvkb1gsqxvm2vvp184spm1kc363sx0byv7cdxmmj4wk51kfv1";
  }) {
    config = {};
  };

  genericImage = name: { inherit name; config.EntryPoint = [ "${_pkgs.${name}}/bin/${_pkgs.${name}.meta.mainProgram or name}" ]; };
in
{ pkgs ? _pkgs, ... }:
(builtins.mapAttrs (n: _: genericImage n) pkgs) // { inherit pkgs; }
#{
  #cowsay = genericImage "cowsay";
  #date = import ./images/date.nix { inherit pkgs; };
  #date-patched = import ./images/date.nix { inherit pkgs; coreutils = pkgs.coreutils-patched; };
  #inherit pkgs;
#}
