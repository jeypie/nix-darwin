{ pkgs, inputs, ... }: {

  environment.variables = {
    EDITOR = "vim";
    LANG = "en_US.UTF-8";
  };

  # allow packages which are not open source
  nixpkgs.config.allowUnfree = true;

  networking.computerName = "jpBook.local";
  networking.hostName = "jpBook";
  # networking.localHostName = "jpBook.local";
  networking.knownNetworkServices = [
  "Wi-Fi"
  "Thunderbolt Bridge"
  "FullStackS Labor RRZ Graz"
  ];
#  networking.dns = [ "8.8.8.8" "1.1.1.1" "192.168.178.254" ];
  networking.dns = [ ];
  users.users."jan.hoepfner".home = "/Users/jan.hoepfner";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true; # outdated
  # nix.package = pkgs.nix;
  nix.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh = { enable = true; };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  system.primaryUser = "jan.hoepfner";

  # nix.configureBuildUsers = true; # outdated

  # enables touch id authentication in shell
  security.pam.services.sudo_local.touchIdAuth = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    # Cisco Anyconnect
    brews = [
        "snyk-cli"
        "age"
        "shellcheck"
        "ansible"
        "pandoc"
    ];

    casks = [
      "1password"
      "daisydisk"
      "drawio"
      # "google-chrome"
      # "jetbrains-toolbox"
      "rambox"
      # "steam"
      # "microsoft-office"
      # "microsoft-auto-update"
      # "microsoft-teams"
      "spotify"
      "wifiman"
      "screen-studio"
      "flameshot"
      "fixkey"
      # "istat-menus"
      # "cleanshot"
      "textsniper"
      #"webex"
      "elgato-stream-deck"
      "elgato-camera-hub"
      "vlc"
      # "obs"
      "daisydisk"
      "airbuddy"
      # "calibre"
      "obsidian"
      "remote-desktop-manager"
      "postman"
    ];
    masApps = {
    #  "Parallels Desktop" = 1085114709;
    #  "PDF Gear" = 6469021132;
    #  "TeleprompterPAD" = 1507218595;
      "Bitwarden" = 1352778147;
    };
  };

  system.defaults = {
    dock.autohide = false;
    dock.mru-spaces =
      false; # i love this, macos will not rearrange the desktops
    dock.magnification = true;
    dock.persistent-apps = [
      "${pkgs.iterm2}/Applications/iTerm2.app"
      "/Applications/Microsoft Outlook.app"
      # "/System/Applications/Calendar.app"
      "/System/Applications/Mail.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/1Password.app"
      "/Applications/Bitwarden.app"
      "/Applications/Spotify.app"
      "/Applications/PyCharm.app"
      "/Applications/Rambox.app"
    #  "/Applications/Arc.app"
      "/Applications/Obsidian.app"
      "/Applications/Google Chrome.app"
    ];
    dock.persistent-others = [
      # sadly need to use CustomUserPreferences at the moment because you can not configure fan etc. here
      #"/Users/jan.hoepfner/Downloads"
      #"/Applications"
    ];
    CustomUserPreferences = {

    };

    loginwindow.LoginwindowText = "FullStackS Oida .. Lets Go!";
    finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "clmv"; # does not work
  };
}
