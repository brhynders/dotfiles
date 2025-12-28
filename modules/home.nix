{ config, lib, pkgs, home-manager, ... }:

let
  # Path to your dotfiles home folder, relative to your home directory
  dotfilesHome = config.home.homeDirectory + "/dotfiles/home";

  # Collect all files under dotfilesHome
  collectFiles = builtins.foldl' (acc: path:
    if builtins.isDirectory path then
      acc
    else
      acc // {
        # Strip the base dir to get the relative path for home.file
        ${lib.replaceStrings [dotfilesHome + "/"] [""] path} = {
          source = path;
          overwrite = true;
        };
      }
  ) {} (builtins.walkDir dotfilesHome);
in

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.users.brandon = {
    home.file = collectFiles;
  };
}
