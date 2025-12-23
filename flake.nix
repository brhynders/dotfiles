{
    description = "Brandon Rhynder's Custom NixOS Config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, ...}:
    {
        nixosConfigurations.homedesktop = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            system = "x86_64-linux";
            modules = [home-manager.nixosModules.home-manager ./machines/homedesktop.nix];
        };
    };
}