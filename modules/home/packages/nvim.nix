{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # 1. Directory Tree
      nvim-tree-lua
      nvim-web-devicons
      nvim-autopairs

      # 2. Terminal
      toggleterm-nvim

      # 3. Theme
      tokyonight-nvim

      # 4. Syntax Highlighting (pre-compiled)
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.lua
        p.vim
        p.vimdoc
        p.python
        p.javascript
        p.bash
      ]))
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true

      -- Theme
      vim.cmd([[colorscheme tokyonight]])

      -- 
      require("nvim-autopairs").setup({
        check_ts = true,
      })

      -- File tree setup & toggle shortcut (<Space> + e)
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

      -- Built-in terminal setup (Ctrl + \)
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-t>]],
        direction = "horizontal",
      })

      -- Easy exit from terminal mode with Escape
      vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", {silent = true, desc="Toggle Terminal" })

      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}

        vim.keymap.set("t", "<esc>", [[<Cmd>ToggleTerm<CR>]], opts)
        vim.keymap.set("t", "<C-t>", [[<Cmd>ToggleTerm<CR>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    '';
  };
}
