{ config, lib, pkgs, ... }:

{
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    services.xserver.enable = true;
    #services.desktopManager.gnome.enable = true;
    #services.displayManager.gdm.enable = true;
      # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;
}
