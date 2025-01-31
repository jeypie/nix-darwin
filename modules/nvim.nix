{ pkgs, inputs, ... }: {
  programs.nixvim = {
    enable = true;

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
