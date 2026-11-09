{ pkgs, inputs, ... }: {
  programs.nixvim = {
    enable = true;
    # we make nixvim follow our nixpkgs in flake.nix, so pin its source explicitly
    nixpkgs.source = inputs.nixpkgs;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
    defaultEditor = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [ "hmts.nvim" "neorg" "nvim-treesitter" ];
      };
      byteCompileLua.enable = true;
    };
  };
}
