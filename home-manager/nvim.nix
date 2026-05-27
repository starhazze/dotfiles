{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    plugins = {
      lualine.enable = true;
      nvim-tree.enable = true;
      web-devicons.enable = true;
      luasnip.enable = true;
      nvim-cmp.enable = true;
    };

    keymaps = [
      {
        mode = "v";
	key = "<C-S-M-D-q>";
        action = ''"+y'';
      }
    ];

     extraPlugins = with pkgs.vimPlugins; [
      mini-pairs
      base16-nvim
      # cmp_luasnip
    ];

    extraConfigLua = ''
      require('colors')
      require('nvim-tree').setup()
      require('mini.pairs').setup()
      require('lualine').setup()

      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          require('nvim-tree.api').tree.open()
        end;
      })

      local function apply_colors()
        dofile(vim.fn.stdpath('config') .. '/lua/colors.lua')
      end
      
      if vim.fn.filereadable(vim.fn.stdpath('config') .. '/lua/colors.lua') == 1 then
        apply_colors()
        vim.api.nvim_create_autocmd('ColorScheme', {
          callback = apply_colors,
        })
      end

    '';

    extraPackages = with pkgs; [
      xclip
      wl-clipboard
    ];
  };
}
