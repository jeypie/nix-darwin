{ pkgs, ... }: {
  environment.systemPackages =
    [
      # pkgs.awscli2
      # pkgs.argocd
      # pkgs.lens
      # pkgs.kubectx
      # pkgs.terragrunt
      # pkgs.vscode
      # kgs.telegram-desktop # currently not working
      # pkgs.glab
      pkgs.git
      pkgs.yq-go
      pkgs.jq
      pkgs.direnv
      pkgs.nix-direnv
      pkgs.k9s
      pkgs.eza
      pkgs.fzf
      pkgs.fzf-zsh
      pkgs.zsh-fzf-tab
      pkgs.oh-my-zsh
      pkgs.zsh-powerlevel10k
      pkgs.go
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.wget
      pkgs.unixtools.watch
      pkgs.tilt
      pkgs.terraform
      pkgs.pre-commit
      pkgs.inetutils
      pkgs.zsh-autosuggestions
      pkgs.zsh-syntax-highlighting
      pkgs.snyk
      pkgs.docker-client
      pkgs.tree
      pkgs.raycast
      pkgs.discord
      pkgs.mas
      pkgs.iterm2
      pkgs.nmap
      pkgs.nix-index
      pkgs.spotify
      pkgs.bartender
      # pkgs.airbuddy
      pkgs.drawio
      pkgs.zoom-us
      pkgs.obsidian
      pkgs.arc-browser
      pkgs.openvpn
      pkgs.unifi
      pkgs.boundary
    ];

  # allow packages which are not open source
  nixpkgs.config.allowUnfree = true;

  users.users.drackthor.home = "/Users/drackthor";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh = {
    enable = true;
  };

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
      # "bitwarden"
      "elgato-stream-deck"
      "vlc"
      "obs"
      "daisydisk"
      "airbuddy"
    ];
    masApps = {
      "Parallels Desktop" = 1085114709;
      "PDF Gear" = 6469021132;
      "TeleprompterPAD" = 1507218595;
    };
  };

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false; # i love this, macos will not rearrange the desktops
    dock.magnification = true;
    dock.persistent-apps = [
      "${pkgs.iterm2}/Applications/iTerm2.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/1Password.app"
      "/Applications/Spotify.app"
      "/Applications/Rambox.app"
      "/Applications/Arc.app"
      "/Applications/Obsidian.app"
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
