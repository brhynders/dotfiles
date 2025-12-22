{ config, lib, pkgs, ... }:

{
    users.users.brandon = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };
}
