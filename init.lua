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
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- my plugins
        -- corlorscheme
        { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
        -- enhanced status line
        { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
        -- some useful icons
        { "nvim-tree/nvim-web-devicons", opts = {} },
        -- file system viewer
        { "nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
        -- fuzzy finder
        { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
        -- --------------------------------------------------------------------------
        -- install language servers, linter, and formatters
        { "mason-org/mason.nvim", opts = {} },
        -- auto-completion
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
            },
        },
        -- lsp config
        { "neovim/nvim-lspconfig" },
        -- formatter
        { "mhartington/formatter.nvim" },
        -----------------------------------------------------------------------------
        -- debug support
        { "mfussenegger/nvim-dap" },
        -- async task runner
        { "stevearc/overseer.nvim" },
        -- collect location list, quick fix list, etc
        { "folke/trouble.nvim", opts = {}, cmd = "Trouble" },
        -----------------------------------------------------------------------------
        -- git wrapper
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
        },
        -- git integration to buffer
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

require("nvim-web-devicons").setup({})

-------------------------------------------------------------------------------
-- colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
require("lualine").setup({ options = { theme = "gruvbox" } })
require("nvim-tree").setup()
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
require("mason").setup()

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" }, -- For vsnip users.
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language servers config
vim.lsp.config("bashls", {
    capabilities = capabilities, -- enable auto completion
})
vim.lsp.enable("bashls")
-- if we use lua_ls on nvim related config files, we need to let it load runtime files
vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("awk_ls", {
    capabilities = capabilities, -- enable auto completion
})
vim.lsp.enable("awk_ls")

vim.lsp.config("pyright", {
    capabilities = capabilities, -- enable auto completion
})
vim.lsp.enable("pyright")

vim.lsp.config("clangd", {
    capabilities = capabilities, -- enable auto completion
})
vim.lsp.enable("clangd")

vim.lsp.config("rust_analyzer", {
    capabilities = capabilities, -- enable auto completion
})
vim.lsp.enable("rust_analyzer")

-- formatter setting up
vim.keymap.set("n", "<F12>", ":Format<CR>", { desc = "F12 to format buffer" })
local util = require("formatter.util")
require("formatter").setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        sh = {
            require("formatter.filetypes.sh").shfmt,
        },

        awk = {
            require("formatter.filetypes.awk").prettier,
        },

        lua = {
            require("formatter.filetypes.lua").stylua,
            -- let stylua search stylua.toml file recursively and in ~/.config/stylua
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },

        python = {
            require("formatter.filetypes.python").black,
        },

        c = {
            require("formatter.filetypes.c").clangformat,
        },

        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },

        rust = {
            require("formatter.filetypes.rust").rustfmt,
        },

        haskell = {
            require("formatter.filetypes.haskell").ormolu,
        },

        -- for any filetype
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})
-------------------------------------------------------------------------------
require("overseer").setup({})
require("neogit").setup({})
