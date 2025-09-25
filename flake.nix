{
  outputs = { nixpkgs, home-manager, ... }@flakeInputs:
  let
     pkgsUnstable = import flakeInputs."nixpkgs-unstable" { system = "x86_64-linux"; config.allowUnfree = true; };
  in
  {
    nixosConfigurations = {
      surface = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit flakeInputs; inherit pkgsUnstable; };
        modules = [
          ./configuration
          {
            system.stateVersion = "25.05";
            networking.hostName = "surface";
          }
          flakeInputs.home-manager.nixosModules.home-manager
          flakeInputs.disko.nixosModules.disko
          flakeInputs.nixos-hardware.nixosModules.microsoft-surface-common
          flakeInputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ];
      };
    };
  };

  inputs = {
    # Stable and Unstable Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
}

