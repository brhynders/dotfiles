{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        nano
        wget
        git
        google-chrome
        vscode-fhs
        podman
        distrobox
        nodejs
        stow
    ];
}
