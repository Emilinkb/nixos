{ config, pkgs, ... }:

{
  # 1. Base U2F PAM module
  security.pam.u2f = {
    enable = true;
    control = "sufficient";
    settings = {
      cue = true;
      authfile = "/home/emilienb/.config/Yubico/u2f_keys";
    };
  };

  # 2. Configure PAM Services
  security.pam.services = {
    # Fallback available for emergency TTY login
    login.u2fAuth = true;

    # Sudo requires U2F
    sudo.u2fAuth = true;
    sudo.unixAuth = false;

    # Swaylock: key touch only, no unix password fallback
    swaylock = {
      u2fAuth = true;
      unixAuth = false;
    };
  };

  # 3. Sudo Options: No password prompt + prompt on every command
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults timestamp_timeout=0
    '';
  };

    # 4. Smart Card daemon
  services.pcscd.enable = true;

  # 5. CLI Utilities
  environment.systemPackages = [
    pkgs.usbutils
    pkgs.procps
  ];

  # 6. Auto-lock daemon: waits for key presence before arming
  systemd.user.services.yubikey-autolock = {
    description = "Lock screen when YubiKey is unplugged";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "2";
      ExecStart = pkgs.writeShellScript "yubikey-autolock" ''
        # Wait until a YubiKey is plugged in at least once
        while ! ${pkgs.usbutils}/bin/lsusb -d 1050: > /dev/null 2>&1; do
          sleep 2
        done

        # Monitor loop for removal
        while true; do
          if ! ${pkgs.usbutils}/bin/lsusb -d 1050: > /dev/null 2>&1; then
            if ! ${pkgs.procps}/bin/pgrep -x swaylock > /dev/null 2>&1; then
              ${pkgs.swaylock}/bin/swaylock -f
            fi

            while ! ${pkgs.usbutils}/bin/lsusb -d 1050: > /dev/null 2>&1; do
              sleep 1
            done
          fi
          sleep 1
        done
      '';
    };
  };
}
