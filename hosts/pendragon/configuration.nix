{
  config,
  pkgs,
  userSettings,
  ...
}:
{
  system.stateVersion = "24.05";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common-desktop.nix
    ../../system/steam.nix
    (./. + "../../../system/wm" + ("/" + userSettings.wm) + ".nix")
  ];

  networking.hostName = "pendragon";

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Select additional kernel modules to install (not automatically loaded)
    # Can also select a specific kernel to use if desired
    extraModulePackages = [
      # Virtual camera for OBS
      config.boot.kernelPackages.v4l2loopback
    ];
    # Modules to be automatically loaded in second stage of boot process
    kernelModules = [
      "v4l2loopback"
    ];

    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackagesFor (
    #   pkgs.buildLinux {
    #     src = pkgs.fetchurl {
    #       url = "https://git.kernel.org/torvalds/t/linux-6.14-rc7.tar.gz";
    #       hash = "sha256-ilYQOd9IxeYERlXPt3G5AU+9ffZ137zFK/Kfu3AR2Uw=";
    #     };
    #     version = "6.14-rc7";
    #   }
    # );
  };

  # Misc things for this machine
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
  };

  networking.firewall.enable = false;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "electro" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.atftpd.enable = true;
  # networking = {
  #   nameservers = ["1.1.1.1"];
  #   firewall.enable = false;

  #   interfaces = {
  #     wlp12s0 = {
  #       useDHCP = true;
  #     };
  #     enp11s0 = {
  #       useDHCP = false;
  #       ipv4.addresses = [
  #         {
  #           address = "10.13.84.1";
  #           prefixLength = 24;
  #         }
  #       ];
  #     };
  #   };

  #   nftables = {
  #     enable = true;
  #     ruleset = ''
  #       table ip filter {
  #         chain input {
  #           type filter hook input priority 0; policy drop;

  #           iifname { "enp11s0" } accept comment "Allow local network to access the router"
  #           iifname "wlp12s0" ct state { established, related } accept comment "Allow established traffic"
  #           iifname "wlp12s0" icmp type { echo-request, destination-unreachable, time-exceeded } counter accept comment "Allow select ICMP"
  #           iifname "wlp12s0" counter drop comment "Drop all other unsolicited traffic from wan"
  #         }
  #         chain forward {
  #           type filter hook forward priority 0; policy drop;
  #           iifname { "enp11s0" } oifname { "wlp12s0" } accept comment "Allow trusted LAN to WAN"
  #           iifname { "wlp12s0" } oifname { "enp11s0" } ct state established, related accept comment "Allow established back to LANs"
  #         }
  #       }

  #       table ip nat {
  #         chain postrouting {
  #           type nat hook postrouting priority 100; policy accept;
  #           oifname "wlp12s0" masquerade
  #         }
  #       }

  #       table ip6 filter {
  #        chain input {
  #           type filter hook input priority 0; policy drop;
  #         }
  #         chain forward {
  #           type filter hook forward priority 0; policy drop;
  #         }
  #       }
  #     '';
  #   };
  # };

  # services = {
  #   kea.dhcp4 = {
  #     enable = true;
  #     settings = {
  #       interfaces-config = {
  #         interfaces = [
  #           "enp11s0"
  #         ];
  #       };
  #       lease-database = {
  #         name = "/var/lib/kea/dhcp4.leases";
  #         persist = true;
  #         type = "memfile";
  #       };
  #       rebind-timer = 2000;
  #       renew-timer = 1000;
  #       subnet4 = [
  #         {
  #           id = 1;
  #           pools = [
  #             {
  #               pool = "10.13.84.2 - 10.13.84.254";
  #             }
  #           ];
  #           subnet = "10.13.84.0/24";
  #         }
  #       ];
  #       valid-lifetime = 4000;
  #     };

  #     # interfaces = ["enp2s0"];
  #     # extraConfig = ''
  #     #   subnet 10.13.84.0 netmask 255.255.255.0 {
  #     #     option routers 10.13.84.1;
  #     #     option domain-name-servers 1.1.1.1;
  #     #     option subnet-mask 255.255.255.0;
  #     #     interface enp2s0;
  #     #     range 10.13.84.2 10.13.84.254;
  #     #   }
  #     # '';
  #   };
  # };

  # Virtualisation
  # virtualisation.containers.enable = true;
  # virtualisation = {
  #   podman = {
  #     enable = true;

  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     dockerCompat = true;

  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
  #   };
  # };
  # environment.systemPackages = with pkgs; [
  #   dive # look into docker image layers
  #   podman-tui # status of containers in the terminal
  #   docker-compose # start group of containers for dev
  #   #podman-compose # start group of containers for dev
  # ];
}
