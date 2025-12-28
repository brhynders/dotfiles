{ config, pkgs, lib, home-manager, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.users.brandon = {
    home.stateVersion = "23.05";
    home.file = {
      ".bashrc".source = ./config/.bashrc;
    };
  };
}