{ config, pkgs, inputs, ... }: {
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/nvim.nix
    ./modules/packages.nix
    ./home/files.nix
    ./home/library.nix
  ];

  programs.git = {
    enable = false;
    userName = "Jan Hoepfner";
    userEmail = "jp@hoepfner.org";
    ignores = [ "*~" ".DS_Store" ];
    extraConfig = {
      core.editor = "nvim";
      github.user = "jeypieitsch";
      init = { defaultBranch = "main"; };
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
       export PATH="$HOME/.rd/bin:$PATH"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    history = {
      append = true;
      share = false;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 10000;
      size = 10000;
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./home;
        file = "zsh-p10k.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "kubectl" "helm" "docker" "terraform" ];
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";
      # KUBECONFIG see home/files.nix
      KUBECONFIG = "/Users/jan.hoepfner/.kube/config-local";
    };
    autocd = true;
    # if zsh startup time is slow, try this to debug
    # zprof.enable = true;
    initExtra = ''
      /Users/jan.hoepfner/.kube/configs/refresh.sh
      function cmdlib() {
        local selected_command
        selected_command=$(cat ~/.library | perl -0 -pe 's/\n+(?!#)/\n\0/g' | bat --plain --language bash --color always |  fzf --read0 --ansi --highlight-line --multi --height=20 --border --prompt="Command: ")
        if [[ -n $selected_command ]]; then
            zle reset-prompt
            BUFFER="$selected_command"
            # zle accept-line # execute instantly
        fi
      }
      zle -N cmdlib
      bindkey '^[l' cmdlib
    '';
    shellAliases = {
      ls = "eza --icons --classify --group-directories-first";
      ll = "ls -lh";
      l = "ls -lah";
      la = "ls -lah -a";
      dir = "ls -lah -a";
      code = "pyCharm";
      k = "kubectl";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetCommand = "fd --type f . /Users/jan.hoepfner/code";
    fileWidgetOptions =
      [ "--preview 'bat --style=numbers --color=always --line-range :500 {}'" ];
    changeDirWidgetCommand = "fd --type d . /Users/jan.hoepfner/code";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
