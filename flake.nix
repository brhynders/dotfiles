{
    description = "Brandon Rhynders Custom NixOS Config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, noctalia, ...}:
    {
        nixosConfigurations.homedesktop = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit home-manager noctalia; };
            system = "x86_64-linux";
            modules = [./machines/homedesktop.nix];
        };
    };
}