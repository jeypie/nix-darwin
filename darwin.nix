{ pkgs, inputs, ... }: {

  environment.variables = {
    EDITOR = "vim";
    LANG = "en_US.UTF-8";
  };

  # allow packages which are not open source
  nixpkgs.config.allowUnfree = true;

  networking.computerName = "drackbook.local";
  networking.hostName = "drackbook";
  # networking.localHostName = "drackbook.local";
  networking.knownNetworkServices = [
    "USB 10/100/1000 LAN"
    "USB 10/100/1000 LAN 2"
    "USB 10/100/1000 LAN 3"
    "USB 10/100/1000 LAN 4"
    "Wi-Fi"
    "Thunderbolt Bridge"
    "iPhone USB USB"
    "FullStackS Labor RRZ Graz"
  ];
  networking.dns = [ "8.8.8.8" "1.1.1.1" ];
  users.users.drackthor.home = "/Users/drackthor";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh = { enable = true; };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  nix.configureBuildUsers = true;

  # enables touch id authentication in shell
  security.pam.enableSudoTouchIdAuth = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    # Cisco Anyconnect

    casks = [
      # "1password"
      "microsoft-office"
      "microsoft-auto-update"
      "microsoft-teams"
      # "jetbrains-toolbox"
      "wifiman"
      # "steam"
      # "google-chrome"
      "screen-studio"
      "fixkey"
      "istat-menus"
      "cleanshot"
      "textsniper"
      # "rambox"
      "webex"
      "citrix-workspace"
      "elgato-stream-deck"
      "vlc"
      "obs"
      "daisydisk"
      "airbuddy"
      "ghostty"
      "calibre"
    ];
    masApps = {
      "Parallels Desktop" = 1085114709;
      "PDF Gear" = 6469021132;
      "TeleprompterPAD" = 1507218595;
      "Bitwarden" = 1352778147;
    };
  };

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces =
      false; # i love this, macos will not rearrange the desktops
    dock.magnification = true;
    dock.persistent-apps = [
      "${pkgs.iterm2}/Applications/iTerm2.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/1Password.app"
      "/Applications/Bitwarden.app"
      "/Applications/Spotify.app"
      "/Applications/Rambox.app"
      "/Applications/Arc.app"
      "/Applications/Obsidian.app"
      "/Users/drackthor/Applications/PyCharm Professional Edition.app"
      "/Applications/Google Chrome.app"
    ];
    dock.persistent-others = [
      # sadly need to use CustomUserPreferences at the moment because you can not configure fan etc. here
      #"/Users/drackthor/Downloads"
      #"/Applications"
    ];
    CustomUserPreferences = {

    };

    loginwindow.LoginwindowText = "FullStackS Oida!";
    finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "clmv"; # does not work
  };
}
