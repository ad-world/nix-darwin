{
  description = "macOS declarative config via nix-darwin + home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    mkSystem = hostFile: nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        hostFile
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.aryaman.imports = [ ./home.nix ];
        }
      ];
    };
  in
  {
    darwinConfigurations = {
      jarvis  = mkSystem ./hosts/jarvis.nix;
      macbook = mkSystem ./hosts/macbook.nix;
    };
  };
}
