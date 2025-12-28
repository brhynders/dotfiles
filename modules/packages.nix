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
        noctalia.packages.${pkgs.system}.default
        alacritty
        wl-clipboard
        wofi
        fuzzel
    ];
}
