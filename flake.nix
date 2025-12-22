{
    description = "Brandon Rhynder's Custom NixOS Config";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";


    outputs = {self, nixpkgs, ...}:
    {
        nixosConfigurations.homedesktop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [./machines/homedesktop.nix];
        };
    };
}