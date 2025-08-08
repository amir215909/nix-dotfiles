{ config, pkgs, ... }:

let
  # Define colors from your Hyprland theme for reuse
  activeBorderColor = "rgba(33ccffee)";
  inactiveBorderColor = "rgba(595959aa)";
  backgroundColor = "rgba(26, 26, 26, 0.8)";
  inputBgColor = "rgba(59, 59, 59, 0.5)";
  textColor = "white";
  highlightColor = "rgba(59, 59, 59, 0.7)";
  mainColor = "rgba(00ff99ee)";
in
{
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "amir";
    userEmail = "ba97140@gmail.com";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "npm" ];
    };
  };

  home.packages = with pkgs; [
    htop
    neofetch
    starship
    brightnessctl
    nerd-fonts.fira-code
    swaylock-effects
    swaybg
    playerctl
    postman
    wofi
    telegram-desktop
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
  };

  # Hyprland configuration converted to Nix
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitors
      monitor = [
        "DP-2, 3440x1440@144, 0x0, 1"
        "DP-1, disable"
      ];

      # Programs
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "${activeBorderColor} ${mainColor} 45deg";
        "col.inactive_border" = inactiveBorderColor;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      # Gestures
      gestures = {
        workspace_swipe = false;
      };

      # Key bindings
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, pkill wofi || $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, L, exec, $lock"

        # Move focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move windows to workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Media keys
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Player controls
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "workspace 8, class:^(discord)$"
        "workspace 8, class:^(org.telegram.desktop)$"
        "workspace 1, class:^(google-chrome)$"
        "workspace 1, class:^(firefox)$"
      ];

      # Device-specific config
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Launch Waybar
      exec-once = "waybar";
    };

    extraConfig = ''
      # Lock screen
      # Use a variable to define the wallpaper path for convenience
      # Make sure to replace "~/Pictures/wallpaper.jpg" with your actual path
      $lockWallpaper = ~/.config/hypr/wallpaper.jpg
      bind = $mainMod, L, exec, swaylock -c 000000 --image $lockWallpaper \
        --indicator --indicator-caps-lock \
        --ring-color 33ccffee --key-hl-color 00ff99ee \
        --ring-ver-color 00ff99ee --ring-wrong-color ff0000ee \
        --line-color 00000000 --inside-color 00000000 \
        --text-color ffffffff --font "Fira Code Nerd Font" --font-size 20

      # Set a wallpaper on startup
      exec-once = swaybg -i $lockWallpaper
    '';
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;

    # Required to enable the hyprland module
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

    # Waybar settings, which will be converted to JSON
    settings = [
      {
        layer = "top";
        position = "top";
        height = 15;
        spacing = 0;
        margin = "0 0 0 0";

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "battery" "pulseaudio" "network" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            default = "";
          };
          on-click = "activate";
        };

        clock = {
          format = "  {:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  {ifname}";
          tooltip-format = "{ipaddr}";
        };

        pulseaudio = {
          format = "  {volume}%";
          format-muted = "  Muted";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          tooltip = false;
        };

        battery = {
          format = "  {capacity}%";
          format-charging = "充電 {capacity}%";
          format-full = "  Full";
          format-alt = "  {time}";
          format-low = "  {capacity}%";
          states = {
            low = 15;
          };
        };
      }
    ];

    # CSS styling for the bar and modules to create the segmented look
    style = ''
      #waybar {
        background-color: ${backgroundColor};
        border-radius: 0;
        color: ${textColor};
        font-family: sans-serif;
        font-size: 14px;
      }
      
      /* Style for individual segments */
      #workspaces, #clock, #battery, #pulseaudio, #network {
        padding: 0 5px;
        background-color: ${inputBgColor};
        border-radius: 10px;
        margin: 5px;
      }

      /* Highlight the active workspace */
      #workspaces button.active {
        background-color: rgb(51, 204, 255);
        opacity: 0.93;
      }
    '';
  };

  # Wofi configuration
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      show = "drun"; # 'drun' mode is for application launchers
    };
    style = ''
      window {
        background-color: ${backgroundColor};
        border: 2px solid ${mainColor};
        border-radius: 10px;
        font-family: "Fira Code Nerd Font";
        color: ${textColor};
        font-size: 14px;
      }
      
      #outer-box {
        margin: 5px;
      }
      
      #input {
        background-color: ${inputBgColor};
        color: ${textColor};
        padding: 5px;
        border-radius: 8px;
        margin: 5px;
        border: none;
      }
      
      #inner-box {
        margin: 5px;
      }
      
      #entry {
        padding: 5px;
        margin: 2px;
      }

      #entry:selected {
        background-color: ${highlightColor};
        border-left: 2px solid ${mainColor};
        border-radius: 8px;
      }

      #text {
        color: ${textColor};
      }

      #img {
        margin-right: 10px;
      }
    '';
  };
}
