{ config, lib, pkgs, ... }:

{
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    services.xserver.enable = true;
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    #services.displayManager.sddm.enable = true;
    #services.displayManager.sddm.wayland.enable = true;
    #services.desktopManager.plasma6.enable = true;

}
