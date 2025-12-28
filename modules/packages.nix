{ config, lib, pkgs, ... }:

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
    ];
}
