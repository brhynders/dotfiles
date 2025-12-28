{ config, lib, pkgs, home-manager, ... }:

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
                "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri";
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

    home-manager.users.yourUserName = { pkgs, ... }: {
        home.stateVersion = "24.05";

        programs.niri.enable = true;

        home.packages = with pkgs; [
            noctalia
            alacritty
            wl-clipboard
            wl-clipboard-history
            wofi
        ];

        xdg.configFile."niri/config.kdl".text = ''
            input {
                keyboard {
                    xkb {
                        layout "us"
                    }
                }
            }

            mod "Alt_L"

            spawn-at-startup "noctalia"

            binds {
                "Alt+Return" spawn "alacritty"
                "Alt+Space" spawn "wofi --show drun"

                "Alt+Q" close-window
                "Alt+Shift+R" reload-config
                "Alt+Shift+E" quit

                "Alt+H" focus left
                "Alt+J" focus down
                "Alt+K" focus up
                "Alt+L" focus right

                "Alt+Shift+H" move left
                "Alt+Shift+J" move down
                "Alt+Shift+K" move up
                "Alt+Shift+L" move right

                "Alt+1" focus-workspace 1
                "Alt+2" focus-workspace 2
                "Alt+3" focus-workspace 3
                "Alt+4" focus-workspace 4

                "Alt+Shift+1" move-to-workspace 1
                "Alt+Shift+2" move-to-workspace 2
                "Alt+Shift+3" move-to-workspace 3
                "Alt+Shift+4" move-to-workspace 4
            }
        '';

        dconf.settings."org/gnome/desktop/interface".gtk-enable-mnemonics = false;

        home.sessionVariables = {
            MOZ_ENABLE_WAYLAND = "1";
            NIXOS_OZONE_WL = "1";
        };
    }

}
