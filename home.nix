{ config, pkgs, ... }:

{
  home.username = "edge";
  home.homeDirectory = "/home/edge";
  home.stateVersion = "25.11";

  # --- Basic Programs ---
  programs.git.enable = true;
  programs.bash.enable = true;
  programs.bash.shellAliases = { btw = "echo I use NixOS, btw"; };



  # --- Mouse ---

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Uncomment if you use any X11 apps
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = 24;
  };


  # This ensures GTK applications (like your file manager) pick it up
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
  };

  # --- Package List ---
  home.packages = [
    pkgs.mpvpaper
    pkgs.btop
    pkgs.pavucontrol
    pkgs.pamixer
    pkgs.wttrbar
    pkgs.kitty
    pkgs.libnotify
    pkgs.rofi
    pkgs.wlogout
    pkgs.hyprlock
    pkgs.light
  ];

  # --- Neovim ---
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number
      set relativenumber 
    '';
  };

  # --- Kitty Transparency ---
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.7";
    };
  };

# --- Hyprland ---
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    "$mainMod" = "SUPER";

    exec-once = [
      "waybar"
      "mpvpaper -o 'no-audio --loop' '*' /home/edge/WallPapers/Choso.mp4"
      "hyprctl setcursor Bibata-Modern-Classic 24"
    ];

    # MERGED BIND LIST
    bind = [
      "$mainMod, R, exec, rofi -show drun"
      "$mainMod, Q, exec, kitty"
      "$mainMod, W, killactive"
      "$mainMod, T, togglefloating"
      "$mainMod, F, fullscreen, 0"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, Left, movefocus, l"
      "$mainMod, Right, movefocus, r"
      "$mainMod, Up, movefocus, u"
      "$mainMod, Down, movefocus, d"
    ];

    # Volume & Brightness (bindle = repeat while held)
    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86MonBrightnessUp, exec, light -A 5"
      ", XF86MonBrightnessDown, exec, light -U 5"
    ];
  }; 
  # --- Waybar ---
  programs.waybar.enable = true;
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    margin = "5 5 0 5";
    modules-left = ["custom/choso" "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ "clock" ];
    modules-right = [ "cpu" "bluetooth" "pulseaudio" "network" "battery" "tray" ];

    # --- Choso menu ---
    "custom/choso" = {
      format = "  ";
      on-click = "choso-menu";
      on-click-right = "kitty"; # Changed to kitty for reliability
      tooltip = false;
    };

    "hyprland/workspaces" = {
      on-click = "activate";
      disable-scroll = true;
      all-outputs = true;
      warp-on-scroll = false;
      format = "{icon}";
      format-icons = {
        "1" = "<span>一</span>";
        "2" = "<span>二</span>";        
        "3" = "<span>三</span>";
        "4" = "<span>四</span>";
        "5" = "<span>五</span>";
        "6" = "<span>六</span>";
        "7" = "<span>七</span>";
        "8" = "<span>八</span>";
        "active" = "";
        "default" = "";
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
      };
    };

    "clock" = { format = " {:%H:%M}"; };
    "cpu" = { format = "{usage}% 󰍛"; };
    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-icons.default = [ "" "" "" ];
    };

    "network" = {
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      format = "{icon}";
      format-wifi = "{icon}";
      format-ethernet = "󰀂";
      format-disconnected = "󰖪";
      tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      tooltip-format-disconnected = "Disconnected";
      interval = 3;
    };


  "bluetooth" = {
      format = "";
      format-disabled = "󰂲";
      format-connected = "󰂱";
      tooltip-format = "Devices connected: {num_connections}";
      on-click = "omarchy-launch-bluetooth";
    };

    "hyprland/window" = {
      format = "{title}";
      max-length = 15;
      separate-outputs = true;
    };

  };




  # --- Styles --- (Paste your CSS here)

 programs.waybar.style = ''
    /* ============================= */
    /* COLOR DEFINITIONS (CHOSO)     */
    /* ============================= */
    @define-color choso-deep-red   #590C0C; 
    @define-color choso-blood      #A61414; 
    @define-color choso-blue       #4B7E9B; 
    @define-color choso-sage       #627371; 
    @define-color choso-mint       #A4BFBD; 
    @define-color choso-dark       #121212;
   
    #custom-choso {
      background-color: @choso-mint;
      color: white;
      font-size: 18px; /* Makes the Arch/Choso icon pop */
      margin-right: 5px;
      padding: 0 12px;
      border-radius: 4px;
    }

    #custom-choso:hover {
      background-color: @choso-blue;
      color: @choso-dark;
    }

    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
      font-weight: bold;
      margin: 0;
      padding: 0;
    }

    window#waybar {
      background-color: transparent;
    }

    /* Main Containers - Now just black backgrounds for the "tray" effect */
    .modules-left, .modules-center, .modules-right {
      background-color: @choso-dark;
      border: 2px solid @choso-dark;
      border-radius: 8px;
      padding: 2px;
    }

    /* ============================= */
    /* MODULE BASE STYLE (The Blocks)*/
    /* ============================= */
    #workspaces button, #window, #cpu, #clock, #battery, #network, #tray, #pulseaudio, #bluetooth {
      margin: 0 3px;     /* This creates the "gap" between blocks */
      padding: 0 10px;   /* Internal spacing of the block */
      border-radius: 4px;
    }

    /* ============================= */
    /* WORKSPACES (Split into boxes) */
    /* ============================= */
    #workspaces button {
      background-color: @choso-deep-red;
      color: @choso-mint;
    }

    #workspaces button.active {
      background-color: @choso-blood;
      color: white;
    }

    #workspaces button:hover {
      background-color: @choso-blue;
    }

    /* ============================= */
    /* INDIVIDUAL MODULE COLORS      */
    /* ============================= */
    
    #window {
      background-color: @choso-blue;
      color: white;
    }

    #clock {
      background-color: @choso-mint;
      color: white;
    }

    #cpu {
      background-color: @choso-deep-red;
      color: @choso-mint;
    }

    #bluetooth {
  background-color: @choso-sage;
  color: white;
   }

    #pulseaudio {
      background-color: @choso-blood;
      color: white;
    }

    #network {
      background-color: @choso-blue;
      color: white;
    }

    #battery {
      background-color: @choso-mint;
      color: white;
    }

    #tray {
      background-color: @choso-deep-red;
    }
  '';
}
