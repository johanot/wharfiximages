{ pkgs, coreutils ? pkgs.coreutils }: {
  name = "date";
  config.EntryPoint = [ "${coreutils}/bin/date" ];
}
