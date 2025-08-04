{
  description = "My NixOS configuration with flakes";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };
  outputs = { self, nixpkgs, flake-utils, home-manager, hyprland, ... }: 
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations = {
      amir-x = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.amir = import ./home-manager/home.nix;
          }
        ];
        specialArgs = {
          inputs = {
            home-manager = home-manager;
            hyprland = hyprland;
          };
        };
      };
    };
  };
}
