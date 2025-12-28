{ config, lib, pkgs, noctalia, ... }:

{
    environment.systemPackages = with pkgs; [
        nano
        wget
        git
        google-chrome
        firefox
        vscode-fhs
        podman
        distrobox
        nodejs
        stow
        noctalia.packages.${pkgs.system}.noctalia-shell
        alacritty
        wl-clipboard
        wofi
        fuzzel
    ];
}
