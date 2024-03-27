-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Themes
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        config = function()
            require('orca.themes.catppuccin')
        end,
    },

    -- Keymaps
    'folke/which-key.nvim',
    -- LSP
    'neovim/nvim-lspconfig',
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
    },
    'williamboman/mason-lspconfig.nvim',

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },
    'onsails/lspkind.nvim',
    -- 'jose-elias-alvarez/null-ls.nvim',
    -- "nvimdev/guard.nvim",
    -- dependencies = {
    --     "nvimdev/guard-collection",
    -- },
    'Hoffs/omnisharp-extended-lsp.nvim',
    -- 'rhysd/vim-clang-format',

    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'f3fora/cmp-spell',
    'KadoBOT/cmp-plugins',
    'hrsh7th/cmp-nvim-lua',
    'mtoohey31/cmp-fish',
    'ray-x/cmp-treesitter',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'saecki/crates.nvim',

    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'jose-elias-alvarez/typescript.nvim',
    -- QuickFix
    {
        "folke/trouble.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- Tree Explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        tag = 'nightly',
    },
    'stevearc/oil.nvim',
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('harpoon').setup()
        end,
    },
    -- Rust
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',
    -- Text
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    'rmagatti/alternate-toggler',
    'gcmt/wildfire.vim',
    'axelvc/template-string.nvim',
    'tpope/vim-surround',
    {
        'Julian/vim-textobj-variable-segment',
        dependencies = { 'kana/vim-textobj-user' }
    },
    -- Movement
    'abecodes/tabout.nvim',
    'phaazon/hop.nvim',
    'tommcdo/vim-exchange',
    -- Comments
    'folke/todo-comments.nvim',
    'numToStr/Comment.nvim',
    -- Bookmarks
    'MattesGroeger/vim-bookmarks',
    'tom-anders/telescope-vim-bookmarks.nvim',
    -- Numbers
    'glts/vim-radical',
    'glts/vim-magnum',
    -- Opener
    'ofirgall/open.nvim',
    -- Sessions
    'rmagatti/auto-session',
    -- Debug
    'mfussenegger/nvim-dap',
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio",
        }
    },
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    'HiPhish/rainbow-delimiters.nvim',
    -- 'josa42/nvim-telescope-minimal-layout',
    'nvim-telescope/telescope-ui-select.nvim',
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } },
        event = 'LspAttach',
    },

    -- Dashboard
    'goolord/alpha-nvim',
    -- UI
    'folke/noice.nvim',
    -- Statusline
    'nvim-lualine/lualine.nvim',
    -- Indents
    'lukas-reineke/indent-blankline.nvim',
    -- Lsp Progress
    'j-hui/fidget.nvim',
    -- Illuminate
    'RRethy/vim-illuminate',
    -- Notifications
    'rcarriga/nvim-notify',
    -- Breadcrumbs
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },
    -- Status Cloumn
    'luukvbaal/statuscol.nvim',
    -- Bufferline
    { 'akinsho/bufferline.nvim', version = "*", },
    -- Colorizer
    'NvChad/nvim-colorizer.lua',
    -- Highlight
    'lukas-reineke/headlines.nvim',
    'bfrg/vim-cpp-modern',
    -- Zen
    'folke/twilight.nvim',
    -- Cpp Implementor
    {
        'eriks47/generate.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },

    -- Utils
    'nvim-treesitter/playground',
}

local opts = {}

require('lazy').setup(plugins, opts)
