require('nvim-treesitter.configs').setup({
    ensure_installed = { 'vim', 'vimdoc', 'lua', 'javascript', 'c', 'typescript', 'rust', 'tsx', 'json', 'markdown',
        'markdown_inline' },

    sync_install = false,
    auto_install = true,
    ignore_install = { 'javascript' },

    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {}
    },
    autotag = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        query = {
            'rainbow-parens',
            html = 'rainbow-tags',
            tsx = 'rainbow-tags',
        },
        strategy = require('ts-rainbow').strategy.global,
    },
    endwise = {
        enable = true,
    },
})
