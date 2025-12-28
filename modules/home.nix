{ config, lib, pkgs, home-manager, ... }:

let
  dotfilesHome = config.home.homeDirectory + "/dotfiles/home";

  # Use walkDir to get all files, then fold into a map
  collectFiles = builtins.foldl' (acc: path:
    if builtins.isDirectory path then
      acc
    else
      acc // {
        # Key must be a string (in quotes)
        "${lib.replaceStrings [dotfilesHome + "/"] [""] path}" = {
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