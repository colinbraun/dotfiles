{ pkgs, userSettings, ... }:
{
  imports = [
    ../app/terminal/kitty.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    extraConfig = builtins.readFile ./hyprland.conf;
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl # Allow control over brightness
    fnott # Notification daemon for WLR-based compositors
    fuzzel # Application launcher like rofi
    grim # Grab imges from wayland compositor
    gsettings-desktop-schemas # Is this needed???
    hyprsunset
    killall
    kitty
    libva-utils # Is this needed???
    numbat # Convenient calculator tool with units
    pamixer # Pulseaduio command-line mixer
    pavucontrol # Pulseaudio volume control
    polkit_gnome
    pyprland
    slurp # Select region in wayland compositor
    swaybg
    wl-clipboard # Command line copy/paste
    wlr-randr # Is this needed?
    wtype # Xdotool type for wayland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    ydotool
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;

    hyprcursor = {
      enable = true;
      size = 24;
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "mod" = "dock";
        "exclusive" = true;
        "passthrough" = false;
        "gtk-layer-shell" = true;
        "height" = 0;
        "modules-left" = [
          "clock"
          "hyprland/workspaces"
        ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          "tray"
          "battery"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
        ];
        "hyprland/window" = {
          "format" = "{}";
        };
        "wlr/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "on-click" = "activate";
          # "format" = "{icon}";
          "persistent_workspaces" = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
        };
        "tray" = {
          "icon-size" = 13;
          "spacing" = 10;
        };
        "clock" = {
          # "format" = "{: %R   %Y/%m/%d}"
          "format" = " {:%R   %Y/%m/%d}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "backlight" = {
          "device" = "intel_backlight";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          "on-scroll-up" = "brightnessctl set 1%+";
          "on-scroll-down" = "brightnessctl -n240 set 1%-";
          "min-length" = 6;
        };
        battery = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          #"format-good" = ""; # An empty format will hide the module
          #"format-full" = "";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "pulseaudio" = {
          "format" = "{icon}  {volume}%";
          "tooltip" = false;
          # "on-click" = "pamixer -t";
          "on-click" = "pavucontrol";
          "on-scroll-up" = "pamixer -i 5";
          "on-scroll-down" = "pamixer -d 5";
          "scroll-step" = 5;
          "format-muted" = "󰸈 {format_source}";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
        };
        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = "";
          # "on-click" = "pamixer --default-source -t";
          "on-click" = "pavucontrol";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "scroll-step" = 5;
        };
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0;
          /* font-family: Cartograph CF Nerd Font, monospace; */
          font-family: 'FiraCode Nerd Font', monospace;
          /* font-family: 'Font Awesome 6', monospace; */
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(21, 18, 27, 0);
          color: #cdd6f4;
      }

      tooltip {
          background: #1e1e2e;
          border-radius: 10px;
          border-width: 2px;
          border-style: solid;
          border-color: #11111b;
      }

      #workspaces button {
          padding: 5px;
          color: #313244;
          margin-right: 5px;
      }

      #workspaces button.active {
          color: #a6adc8;
      }

      #workspaces button.focused {
          color: #a6adc8;
          background: #eba0ac;
          border-radius: 10px;
      }

      #workspaces button.urgent {
          color: #11111b;
          background: #a6e3a1;
          border-radius: 10px;
      }

      #workspaces button:hover {
          background: #11111b;
          color: #cdd6f4;
          border-radius: 10px;
      }

      #custom-language,
      #custom-updates,
      #custom-caffeine,
      #custom-weather,
      #window,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #backlight {
          background: #1e1e2e;
          padding: 0px 10px;
          margin: 3px 0px;
          margin-top: 10px;
          border: 1px solid #181825;
      }

      #tray {
          border-radius: 10px;
          margin-right: 10px;
      }

      #workspaces {
          background: #1e1e2e;
          border-radius: 10px;
          margin-left: 10px;
          padding-right: 0px;
          padding-left: 5px;
      }

      #custom-caffeine {
          color: #89dceb;
          border-radius: 10px 0px 0px 10px;
          border-right: 0px;
          margin-left: 10px;
      }

      #custom-language {
          color: #f38ba8;
          border-left: 0px;
          border-right: 0px;
      }

      #window {
          border-radius: 10px;
          margin-left: 60px;
          margin-right: 60px;
      }

      #clock {
          color: #fab387;
          border-radius: 10px 10px 10px 10px;
          margin-left: 5px;
          border-right: 0px;
      }

      #network {
          color: #f9e2af;
          border-left: 0px;
          border-right: 0px;
      }

      #pulseaudio {
          color: #89b4fa;
          border-left: 0px;
          border-right: 0px;
      }

      #pulseaudio.microphone {
          color: #cba6f7;
          border-radius: 0px 10px 10px 0px;
          border-left: 0px;
          border-right: 0px;
          margin-right: 5px;
      }

      #battery {
          color: #a6e3a1;
          border-radius: 10px 0px 0px 10px;
          margin-right: 0px;
          border-left: 10px;
      }

      #custom-weather {
          border-radius: 0px 10px 10px 0px;
          border-right: 0px;
          margin-left: 0px;
      }
    '';
  };

  home.file.".config/pypr/config.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "${userSettings.term} --class scratchpad"
    margin = 50

    [scratchpads.numbat]
    command = "${userSettings.term} --class scratchpad -e numbat"
    margin = 50
  '';

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      terminal = "${userSettings.term}";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };
  services.fnott.enable = true;
  services.fnott.settings = {
    main = {
      anchor = "bottom-right";
      stacking-order = "top-down";
      min-width = 400;
      border-size = 0;
    };
  };
}
