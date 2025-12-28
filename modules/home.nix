{ config, pkgs, lib, home-manager, noctalia, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.users.brandon = {
    home.stateVersion = "23.05";
    home.file = {
      ".bashrc".source = ../config/.bashrc;
      "~/.config/niri/niri.conf".source = ../config/niri.kdl;
    };

     home.packages = [
            noctalia.packages.${pkgs.system}.default
            pkgs.alacritty
            pkgs.wl-clipboard
            pkgs.wofi
     ];

      dconf.settings."org/gnome/desktop/interface".gtk-enable-mnemonics = false;

      home.sessionVariables = {
          MOZ_ENABLE_WAYLAND = "1";
          NIXOS_OZONE_WL = "1";
      };
  };
}