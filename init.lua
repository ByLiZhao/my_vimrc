-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- my plugins
    -- corlorscheme
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    -- some useful icons
    { "nvim-tree/nvim-web-devicons", opts = {} },
    -- fuzzy finder
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
    -- auto-completion
    { 'hrsh7th/nvim-cmp',  dependencies = { 'hrsh7th/cmp-nvim-lsp', 
                                            'hrsh7th/cmp-buffer',
				            'hrsh7th/cmp-path',
				            'hrsh7th/cmp-cmdline',
				            'hrsh7th/cmp-vsnip',
				            'hrsh7th/vim-vsnip'} },
   -- lsp config
   {"neovim/nvim-lspconfig"},
   -- install language servers
   { "mason-org/mason.nvim", opts = {} },
   -- file system viewer
   { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons", }, },
   -- enhanced status line
   { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, },
   -- debug support
   { 'mfussenegger/nvim-dap', },
   -- async task runner
   { 'stevearc/overseer.nvim',},
   -- git wrapper
   { "NeogitOrg/neogit", dependencies = { "nvim-lua/plenary.nvim", 
                                          "sindrets/diffview.nvim", 
					  "nvim-telescope/telescope.nvim", }, },
   -- collect location list, quick fix list, etc
   { "folke/trouble.nvim", opts = {}, cmd = "Trouble", },
   -- git integration to buffer
   { "lewis6991/gitsigns.nvim" },
   -- formatter
   { 'mhartington/formatter.nvim' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require'nvim-web-devicons'.setup {}

-- colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require("mason").setup()
require("nvim-tree").setup()
require('lualine').setup{options = { theme = 'gruvbox' }}
require("overseer").setup{}
require('neogit').setup{}
require("formatter").setup{}
