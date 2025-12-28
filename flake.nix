{
    description = "Brandon Rhynder's Custom NixOS Config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia.url ="github:noctalia-dev/noctalia-shell";
    };

    outputs = {self, nixpkgs, home-manager, noctalia, ...}:
    {
        nixosConfigurations.homedesktop = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit home-manager noctalia; };
            system = "x86_64-linux";
            modules = [home-manager.nixosModules.home-manager ./machines/homedesktop.nix];
        };
    };
}