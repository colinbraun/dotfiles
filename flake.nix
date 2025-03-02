{
  description = "Electro's Flake";

  outputs = inputs @ {self, ...}: let
    # SYSTEM SETTINGS
    systemSettings = {
      system = "x86_64-linux";
      timezone = "America/Chicago";
      locale = "en_US.UTF-8";
    };

    # USER SETTINGS
    userSettings = {
      username = "electro";
      name = "Electro";
      email = "electrolitic21@gmail.com";
      dotfilesDir = "~/.dotfiles";
      wm = "hyprland";
      term = "kitty";
      browser = "librewolf";
      editor = "nvim";
      fileManager = "thunar";
    };

    lib = inputs.nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    pkgs = import inputs.nixpkgs {
      system = systemSettings.system;
      config.allowUnfree = true;
    };
    pkgsAArch64 = import inputs.nixpkgs {
      system = "aarch64-linux";
      config.allowUnfree = true;
    };

    home-manager = inputs.home-manager;
  in {
    nixosConfigurations = {
      electro-nixos = lib.nixosSystem {
        system = systemSettings.system;
        modules = [./hosts/electro-nixos/configuration.nix];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
      pendragon = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./hosts/pendragon/configuration.nix
          # inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
      turtwig = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/turtwig/configuration.nix
        ];
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };

    homeConfigurations = {
      "electro@electro-nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/electro-nixos/home.nix];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
      "electro@pendragon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/pendragon/home.nix
        ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
      "electro@turtwig" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgsAArch64;
        modules = [
          ./hosts/turtwig/home.nix
        ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # suyu.url = "git+https://git.suyu.dev/suyu/nix-flake";
    # suyu.inputs.nixpkgs.follows = "nixpkgs";
  };
}
