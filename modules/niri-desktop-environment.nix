{ config, lib, pkgs, home-manager, noctalia, ... }:

{
    ############################
    # Wayland & session basics #
    ############################

    programs.xwayland.enable = true;

    # Make niri available system-wide (greetd needs it)
    programs.niri.enable = true;

    services.dbus.enable = true;
    security.polkit.enable = true;

    ###################
    # Login manager   #
    ###################

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
            command =
                "${pkgs.tuigreet}/bin/tuigreet --cmd niri";
            };
        };
    };

    ###################
    # Portals (important for Wayland apps)
    ###################

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    ###################
    # Audio (optional)
    ###################

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };
}
