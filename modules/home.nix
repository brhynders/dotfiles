{ config, lib, pkgs, home-manager, ... }:

let
  # optional: define username for convenience
  username = "brandon";
in

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.users.${username} = let
    dotfilesHome = "/home/${username}/dotfiles/home";   # must hardcode or use config.users.username.home
    dotfilesHomeSlash = dotfilesHome + "/";
    
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
    home.stateVersion = "23.05";  # required
    home.file = collectFiles dotfilesHome;
  };
}