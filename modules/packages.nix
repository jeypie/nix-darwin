{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nix-direnv
    nix-index
    nixd
    nixfmt
    oh-my-zsh
    zsh-autosuggestions
    zsh-fzf-tab
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];
}
