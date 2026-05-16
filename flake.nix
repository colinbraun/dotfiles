{
  description = "Electro's Flake";

  outputs =
    inputs@{ ... }:
    let
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
        browser = "firefox";
        editor = "nvim";
        fileManager = "thunar";
      };

      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config.allowUnfree = true;
      };
      pkgsAArch64 = import inputs.nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };

      home-manager = inputs.home-manager;
    in
    {
      nixosConfigurations = {
        electro-nixos = inputs.nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./hosts/electro-nixos/configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
        pendragon = inputs.nixpkgs.lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            ./hosts/pendragon/configuration.nix
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
            inherit inputs;
          };
        };
        turtwig = inputs.nixpkgs.lib.nixosSystem {
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
          pkgs = pkgs;
          modules = [ ./hosts/electro-nixos/home.nix ];
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
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
