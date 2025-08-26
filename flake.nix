{
  description = "Electro's Flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
      # pkgs-stable = import inputs.nixpkgs-stable {
      #   system = systemSettings.system;
      #   config.allowUnfree = true;
      # };
      pkgsAArch64 = import inputs.nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };

      home-manager = inputs.home-manager;
      # home-manager-stable = inputs.home-manager-stable;
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
            # inputs.sops-nix.nixosModules.sops
            # {
            #   nix.settings = {
            #     substituters = ["https://cosmic.cachix.org/"];
            #     trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
            #   };
            # }
            # inputs.nixos-cosmic.nixosModules.default
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
    # nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager-stable.url = "github:nix-community/home-manager/release-25.05";
    # home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    # nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";
    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # suyu.url = "git+https://git.suyu.dev/suyu/nix-flake";
    # suyu.inputs.nixpkgs.follows = "nixpkgs";
  };
}
