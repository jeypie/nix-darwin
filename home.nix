{ config, pkgs, inputs,... }:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./modules/nvim.nix
    ./modules/packages.nix
  ];


  programs.git = {
    enable = false;
    userName = "Daniel Drack";
    userEmail = "daniel.drack@fullstacks.eu";
    ignores = [ "*~" ".DS_Store" ];
    extraConfig = {
      core.editor = "nvim";
      github.user = "DrackThor";
      init = { defaultBranch = "main"; };
      diff = { external = "${pkgs.difftastic}/bin/difft"; };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.share = false;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
    };
    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "nvim";
    };
    autocd = true;
    # if zsh startup time is slow, try this to debug
    # zprof.enable = true;
    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      source ${pkgs.terraform}/share/bash-completion/completions/terraform
      compdef __start_kubectl k
      compdef __start_helm h
      compdef __start_terraform t
      # recreate ~/.kube/config from ~/.kube/configs/*
      /Users/drackthor/.kube/configs/refresh.sh
      # export KUBECONFIG=$(find "/Users/drackthor/.kube/configs" -maxdepth 1 -type f - -exec realpath {} \; | paste -sd ':' -)
      '';
    shellAliases = {
      ls="eza --icons --classify --group-directories-first";
      ll="ls -lh";
      l="ls -lah";
      la="ls -lah -a";
      dir="ls -lah -a";
      k="kubectl";
      h="helm";
      t="terraform";
      gst="git status";
      ga="git add";
      gcmsg="git commit -m";
      code="pycharm";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetCommand = "fd --type f . /Users/drackthor/code";
    fileWidgetOptions = [ "--preview 'bat --style=numbers --color=always --line-range :500 {}'" ];
    changeDirWidgetCommand = "fd --type d . /Users/drackthor";
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
