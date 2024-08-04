{ config, inputs, lib, pkgs, self, ... }:
let
  inherit (lib) mkIf;

  cfg = config.Ark.home.hyprland;
  user = config.Ark.userName;

  terminal = config.Ark.home.terminal.emulator;
  chromium = config.Ark.home.chromium.enable;
  manufacturer = config.Ark.manufacturer;
  nvidia = (config.Ark.hardware.gpu.type == "nvidia");
in {
  imports = [ inputs.hyprland.nixosModules.default ];

  config = mkIf cfg.enable {
    environment.systemPackages = [ self.packages.${pkgs.system}.hyprZoom ];
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    programs.xwayland.enable = true;
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    services.displayManager.defaultSession = "hyprland";
    services.displayManager.sessionPackages =
      [ inputs.hyprland.packages.${pkgs.system}.default ];

    home-manager.users.${user} = {
      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;

        settings = {
          monitor = [
            "eDP-1, 1920x1080@144, 0x0, 1"
            "HDMI-A-1, 1920x1080@60, 1920x0, 1"
          ];

          env = [
            (mkIf nvidia "LIVBA_DRIVER_NAME,nvidia")
            (mkIf nvidia "XDG_SESSION_TYPE,wayland")
            (mkIf nvidia "__GLX_VENDOR_LIBRARY_NAME,nvidia")
          ];

          cursor = mkIf nvidia {
            no_hardware_cursors = true;
            allow_dumb_copy = true;
          };

          exec-once = [
            # Clipboard
            "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${
              lib.getExe pkgs.cliphist
            } store"
            "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${
              lib.getExe pkgs.cliphist
            } store"

            # Polkit
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

            # Keyring
            "gnome-keyring-daemon --start --components=secrets"
          ];

          misc = {
            animate_manual_resizes = false;
            animate_mouse_windowdragging = false;

            enable_swallow = false;

            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;

            disable_autoreload = true;
            allow_session_lock_restore = true;

            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            background_color = "rgb(000000)";
          };

          bind = [
            # Apps
            "Super, C, exec, ${pkgs.vscode}/bin/code"
            "Super, E, exec, ${pkgs.nautilus}/bin/nautilus --new-window"
            ''
              Super, S, exec, XDG_CURRENT_DESKTOP="gnome" ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center''
            ''
              , Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -''
            "Super, Space, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"

            # Actions
            "Super, Q, killactive"
            "Super Shift, Q, exec, pkill Hyprland"
            "Super, F, fullscreen"
            "Super, T, togglefloating"

            # Play/Pause
            ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play"
            ", XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl pause"

            # Zoom
            "Super, mouse_down, exec, ${
              self.packages.${pkgs.system}.hyprZoom
            }/bin/hypr-zoom -duration=10 -steps=15"
            "Super, mouse_up, exec, ${
              self.packages.${pkgs.system}.hyprZoom
            }/bin/hypr-zoom -duration=10 -steps=15"

            # Workspaces
            "Super, 1, workspace, 1"
            "Super, 2, workspace, 2"
            "Super, 3, workspace, 3"
            "Super, 4, workspace, 4"
            "Super, 5, workspace, 5"
            "Super, 6, workspace, 6"
            "Super, 7, workspace, 7"
            "Super, 8, workspace, 8"
            "Super, 9, workspace, 9"
            "Super, 0, workspace, 10"

            "Super Shift, 1, movetoworkspace, 1"
            "Super Shift, 2, movetoworkspace, 2"
            "Super Shift, 3, movetoworkspace, 3"
            "Super Shift, 4, movetoworkspace, 4"
            "Super Shift, 5, movetoworkspace, 5"
            "Super Shift, 6, movetoworkspace, 6"
            "Super Shift, 7, movetoworkspace, 7"
            "Super Shift, 8, movetoworkspace, 8"
            "Super Shift, 9, movetoworkspace, 9"
            "Super Shift, 0, movetoworkspace, 10"
          ] ++ (if (terminal == "foot") then
            [ "Super, Return, exec, foot" ]
          else
            [ ]) ++ (if chromium then [ "Super, W, exec, chromium" ] else [ "Super, W, exec, firefox" ])
            ++ (if (manufacturer == "asus") then
              [ ",XF86Launch4, exec, asusctl profile -n" ]
            else
              [ ]);

          bindm =
            [ "Super, mouse:272, movewindow" "Super, mouse:273, resizewindow" ];

          bindl = [
            # Mute
            ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
            ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
          ];

          bindr = [
            # CapsLock OSD
            "CAPS, Caps_Lock, exec, swayosd-client --caps-lock"
          ];

          bindle = [
            # Brightness
            ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
            ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

            # Keyboard LED brightness
            ", XF86KbdBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight set +33%"
            ", XF86KbdBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -d *::kbd_backlight set 33%-"

            # Volume
            ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
            ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
            ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl position 10-"
            ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl position 10+"
          ];

          windowrulev2 = [
            "noblur,class:(steam)$"
            "minsize 1 1, title:^()$,class:^(steam)$"
            "forcergbx,class:(steam)$"
          ];
        };
      };

      services.swayosd.enable = true;
    };
  };
}
