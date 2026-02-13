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
    taps = [
      "azure/azd"
    ];
    brews = [
      "azure-cli"
      "azd"
      "bat"
      "conftest"
      "direnv"
      "dive"
      "docker-credential-helper"
      "eza"
      "fd"
      "ffmpeg"
      "fzf"
      "git"
      "go"
      "gomplate"
      "graphviz"
      "helm"
      "inetutils"
      "jq"
      "k9s"
      "kubernetes-cli"
      "mani"
      "mas"
      "mtr"

      "nmap"
      "openvpn"
      "opa"
      "pre-commit"
      "pyenv"
      "python@3.12"
      "ripgrep"
      "rsync"
      "ruff"
      "snyk-cli"
      "terraform"
      "tilt"
      "tree"
      "uv"
      "watch"
      "wget"
      "yq"
    ];

    casks = [
      # Passwords & Security
      "1password"
      "bitwarden"

      # Browsers
      "brave-browser"
      "google-chrome"

      # Communication
      "microsoft-teams"
      "rambox"
      "webex"

      # Development
      "claude-code"
      "chatgpt"
      "devpod"
      "drawio"
      "ghostty"
      "intellij-idea"
      "jetbrains-toolbox"
      "podman-desktop"
      "postman"
      "rancher"

      # Media & Streaming
      "qobuz"
      "roon"
      "screen-studio"
      "vlc"

      # Productivity & Office
      "microsoft-auto-update"
      "microsoft-office"
      "obsidian"
      "raycast"

      # Utilities
      "airbuddy"
      "bartender"
      "calibre"
      "commander-one"
      "daisydisk"
      "elgato-camera-hub"
      "elgato-stream-deck"
      "fixkey"
      "flameshot"
      "remote-desktop-manager"
      "textsniper"
      "wifiman"
      "windows-app"

      # Fonts
      "font-jetbrains-mono-nerd-font"

      # Gaming & Other
      "steam"
    ];
    masApps = {
    #  "Parallels Desktop" = 1085114709;
    #  "PDF Gear" = 6469021132;
    #  "TeleprompterPAD" = 1507218595;
    #  "Bitwarden" = 1352778147;
    };
  };

  system.defaults = {
    dock.autohide = false;
    dock.mru-spaces =
      false; # i love this, macos will not rearrange the desktops
    dock.magnification = true;
    dock.persistent-apps = [
      "/Applications/Ghostty.app"
      "/Applications/IntelliJ IDEA.app"
      "/Applications/Microsoft Outlook.app"
      "/System/Applications/Mail.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/1Password.app"
      "/Applications/Bitwarden.app"
      "/System/Applications/Music.app"
      "/Applications/Rambox.app"
      "/Applications/Google Chrome.app"
      "/Applications/Remote Desktop Manager.app"
    ];
    dock.persistent-others = [
      # sadly need to use CustomUserPreferences at the moment because you can not configure fan etc. here
      #"/Users/jan.hoepfner/Downloads"
      #"/Applications"
    ];
    CustomUserPreferences = {

    };

    loginwindow.LoginwindowText = "FullStackS Oida .. !";
    finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "clmv"; # does not work
  };
}
