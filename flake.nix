{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{self, nixpkgs, ...}: {
    nixosConfigurations.supersmash = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # inputs.disko.nixosModules.disko
        # inputs.nixos-facter-modules.nixosModules.facter
        # ./facter.json
        # ./disk.nix
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}
