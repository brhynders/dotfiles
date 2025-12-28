{ config, lib, pkgs, home-manager, ... }:

let
  dotfilesHome = config.home.homeDirectory + "/dotfiles/home";
  dotfilesHomeSlash = dotfilesHome + "/";  # precompute string with trailing slash

  # Recursive function to collect all files
  collectFiles = dir:
    let
      entries = builtins.attrNames (builtins.readDir dir);
    in
      lib.foldl' (acc: name:
        let
          path = dir + "/" + name;
        in
          if builtins.isDirectory path then
            acc // collectFiles path
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
      ) {} entries;
in

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.users.brandon = {
    home.stateVersion = "23.05"; # required
    home.file = collectFiles dotfilesHome;
  };
}