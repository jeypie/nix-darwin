{ pkgs, ... }: {
  home.packages = with pkgs; [
    cnquery
    cnspec
    fzf-zsh
    nerd-fonts.meslo-lg
    nix-direnv
    nix-index
    nixd
    nixfmt-rfc-style
    oh-my-zsh
    zsh-autosuggestions
    zsh-fzf-tab
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];
}
