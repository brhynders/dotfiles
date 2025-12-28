{ config, lib, pkgs, home-manager, ... }:

let
  dotfilesHome = config.home.homeDirectory + "/dotfiles/home";
  dotfilesHomeSlash = dotfilesHome + "/"; # <-- precompute the slash version

  collectFiles = builtins.foldl' (acc: path:
    if builtins.isDirectory path then
      acc
    else
      let
        relPath = lib.replaceStrings [dotfilesHomeSlash] [""] path;
      in
      acc // {
        "${relPath}" = {
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