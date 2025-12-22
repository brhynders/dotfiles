{ config, lib, pkgs, ... }:

{
    # Nix Settings
    system.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Locale
    networking.networkmanager.enable = true;
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "eurosign:e,caps:escape";
}
