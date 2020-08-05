{ pkgs }: {
  name = "date";
  config.EntryPoint = [ "${pkgs.coreutils}/bin/date" ];
}
