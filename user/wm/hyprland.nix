{
  config,
  pkgs,
  userSettings,
  ...
}:
let
  wallpaperPath = "${config.xdg.userDirs.pictures}/Wallpapers/wallpaper.png";
in
{
  imports = [
    ../app/terminal/kitty.nix
    # ../app/terminal/ghostty.nix
  ];

  home.file."${wallpaperPath}".source = ./super-mario-world-map-by-matt-vince-1920x1080.png;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = { };
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      # monitor=,preferred,auto,auto
      monitor=eDP-1,1920x1080,0x0,1

      # Variables
      $terminal = ${userSettings.term}
      $fileManager = ${userSettings.fileManager}
      $menu = fuzzel
      $mainMod = SUPER

      # Some default env vars.
      env = QT_QPA_PLATFORMTHEME,qt6ct # change to qt6ct if you have that

      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 2

          touchpad {
              natural_scroll = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          # gaps_in = 2
          gaps_in = 1
          # gaps_out = 5
          gaps_out = 0
          border_size = 2
          # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          # col.active_border = rgba(6300a9ee) rgba(000059ee) 45deg
          col.active_border = rgba(bf00ffee) rgba(000059ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = master

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
          # cursor_inactive_timeout = 5
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          # rounding = 10

          blur {
              enabled = true
              size = 3
              passes = 1

              vibrancy = 0.1696
          }

          shadow {
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

      }

      animations {
          enabled = true

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      master {
          # Make master window take up half the space. Default is 0.55.
          mfact = 0.5
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
          disable_hyprland_logo = true
          enable_anr_dialog = false # ANR = Application Not Responding
      }

      ecosystem {
          no_update_news = true
          no_donation_nag = true
      }


      # BINDS
      bind = $mainMod, RETURN, exec, $terminal
      bind = $mainMod, Q, killactive
      bind = $mainMod, M, exit
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating
      bind = $mainMod, D, exec, $menu
      bind = $mainMod, I, layoutmsg, orientationcycle left top

      # Move focus
      # bind = $mainMod, h, workspace, e-1
      # bind = $mainMod, l, workspace, e+1
      # bind = $mainMod, j, cyclenext
      # bind = $mainMod, k, cyclenext, prev
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, j, movefocus, d
      bind = $mainMod, k, movefocus, u

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e-1
      bind = $mainMod, mouse_up, workspace, e+1

      # Screenshot
      bindi = , Print, exec, grim -g "$(slurp -d)" - | wl-copy

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Volume
      binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
      binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-

      # Brightness
      binde=,XF86MonBrightnessUp,exec,brightnessctl set +5%
      binde=,XF86MonBrightnessDown,exec,brightnessctl -n240 set 5%-



      # Window rules
      windowrule=opacity 0.95,title:(.*)(Discord)$
      exec-once=swaybg --image "${wallpaperPath}"
      exec-once=pypr
      # exec-once=swww init
      # ; swww img ~/Downloads/output.gif
      exec-once=waybar
      # exec-once=hyprctl setcursor rose-pine-hyprcursor 26
      # exec-once=${userSettings.term}
      # exec-once=discord
      # # Start up these programs in separate workspaces
      exec-once=[workspace 1 silent] ${userSettings.term}
      exec-once=[workspace 2 silent] ${userSettings.browser}
      exec-once=[workspace 3 silent] discord

      # windowrule = workspace 1, ${userSettings.term}
      # windowrule = workspace 2, ${userSettings.browser}
      # Need this b/c discord starts up in a different way
      windowrule = workspace 3 silent, class:discord


      # Pyprland
      bind=SUPER,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop
      bind=SUPER,N,exec,pypr toggle numbat && hyprctl dispatch bringactivetotop
      # bind=SUPER,D,exec,hypr-element
      bind=SUPER,code:172,exec,pypr toggle pavucontrol && hyprctl dispatch bringactivetotop
      $scratchpadsize = size 80% 85%

      $scratchpad = class:^(scratchpad)$
      windowrule = float,$scratchpad
      windowrule = $scratchpadsize,$scratchpad
      windowrule = workspace special silent,$scratchpad
      windowrule = center,$scratchpad

      # Cursors
      env = XCURSOR_SIZE,24
      # env = HYPRCURSOR_THEME,rose-pine-hyprcursor
      # env = HYPRCURSOR_SIZE,26
    '';
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
    # keepmenu # Dmenu/Rofi/Fuzzel/... frontend for Keepass databases
    kitty
    # feh # An image viewer
    killall
    libva-utils # Is this needed???
    pavucontrol # Pulseaudio volume control
    pamixer # Pulseaduio command-line mixer
    polkit_gnome
    pyprland
    wl-clipboard # Command line copy/paste
    # hyprcursor
    # hyprpicker # Color picker
    # hypridle # Hyprland idle daemon
    # hyprlock # Hyprland's GPU-accelerated screen locking utility
    # hyprnome # Gnome-like workspace switching in hyprland
    # hyprdim # Automatically dim windows in Hyprland when switching between them (active/non-active)
    swaybg
    # pinentry-gnome3 # Double check if interested
    libsForQt5.qt5.qtwayland # Qt for wayland
    numbat # Convenient calculator tool with units
    qt6.qtwayland # Does this package exist???
    slurp # Select region in wayland compositor
    # tesseract4 # OCR engine
    # wev # Wayland event viewer, a debugging tool
    wlr-randr # Is this needed?
    # wlsunset
    hyprsunset
    wtype # Xdotool type for wayland
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    ydotool
    # zenity # Tool to display dialogs from the commandline and shell scripts
    # (pkgs.writeScriptBin "screenshot-ocr" ''
    #   #!/bin/sh
    #   imgname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S).png"
    #   txtname="/tmp/screenshot-ocr-$(date +%Y%m%d%H%M%S)"
    #   txtfname=$txtname.txt
    #   grim -g "$(slurp)" $imgname;
    #   tesseract $imgname $txtname;
    #   wl-copy -n < $txtfname
    # '')
    # (pkgs.writeScriptBin "sct" ''
    #   #!/bin/sh
    #   killall wlsunset &> /dev/null;
    #   if [ $# -eq 1 ]; then
    #     temphigh=$(( $1 + 1 ))
    #     templow=$1
    #     wlsunset -t $templow -T $temphigh &> /dev/null &
    #   else
    #     killall wlsunset &> /dev/null;
    #   fi
    # '')
    # (pkgs.writeScriptBin "obs-notification-mute-daemon" ''
    #   #!/bin/sh
    #   while true; do
    #     if pgrep -x .obs-wrapped > /dev/null;
    #       then
    #         pkill -STOP fnott;
    #         #emacsclient --eval "(org-yaap-mode 0)";
    #       else
    #         pkill -CONT fnott;
    #         #emacsclient --eval "(if (not org-yaap-mode) (org-yaap-mode 1))";
    #     fi
    #     sleep 10;
    #   done
    # '')
    # (pkgs.writeScriptBin "suspend-unless-render" ''
    #   #!/bin/sh
    #   if pgrep -x nixos-rebuild > /dev/null || pgrep -x home-manager > /dev/null || pgrep -x kdenlive > /dev/null || pgrep -x FL64.exe > /dev/null || pgrep -x blender > /dev/null || pgrep -x flatpak > /dev/null;
    #   then echo "Shouldn't suspend"; sleep 10; else echo "Should suspend"; systemctl suspend; fi
    # '')
  ];

  # home.file.".icons" = {
  #   recursive = true;
  #   source = ./cursor/rose-pine-hyprcursor;
  # };
  # home.file.".icons/default" = {
  #   recursive = true;
  #   source = ./cursor/rose-pine-hyprcursor;
  # };

  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.package = pkgs.yaru-theme;
  home.pointerCursor.name = "Yaru";
  home.pointerCursor.size = 24;

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

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "${userSettings.term} --class scratchpad"
    margin = 50

    [scratchpads.numbat]
    command = "${userSettings.term} --class scratchpad -e numbat"
    margin = 50
  '';
  # [scratchpads.pavucontrol]
  # command = "pavucontrol"
  # margin = 50
  # unfocus = "hide"
  # animation = "fromTop"

  # services.udiskie.enable = true; # Removable disk automounter
  # services.udiskie.tray = "always";
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      # font = userSettings.font + ":size=13";
      # terminal = "${pkgs.kitty}/bin/kitty";
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
      # title-font = userSettings.font + ":size=14";
      # summary-font = userSettings.font + ":size=12";
      # body-font = userSettings.font + ":size=11";
      border-size = 0;
    };
  };
}
