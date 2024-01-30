require('nvim-treesitter.configs')
    .setup({
        ensure_installed = { 'vim', 'vimdoc', 'lua', 'javascript', 'c',
            'typescript', 'rust', 'tsx', 'json', 'markdown',
            'markdown_inline', 'cpp' },
        sync_install = false,
        auto_install = true,
        ignore_install = { 'javascript' },
        highlight =
        {
            enable = true,
            disable = {},
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = {} },
        autotag = { enable = true },
        endwise =
        {
            enable = true,
        },
    })
local rainbow = require('rainbow-delimiters')
require('rainbow-delimiters.setup')
    .setup({
        strategy =
        {
            [''] = rainbow.strategy['global'],
        },
        query =
        {
            [''] = 'rainbow-delimiters',
            ['lua'] = 'rainbow-blocks',
        },
        highlight =
        {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    })
