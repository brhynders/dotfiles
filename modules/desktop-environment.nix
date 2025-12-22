{ config, lib, pkgs, ... }:

{
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    services.xserver.enable = true;
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
}
