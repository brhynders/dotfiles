{ config, pkgs, lib, home-manager, ... }:

{
  home-manager.users.brandon = {
    home.stateVersion = "23.05";
    home.file = {
      ".bashrc" = {
        source = ./config/.bashrc;
        overwrite = true;
      };
    };
  };
}