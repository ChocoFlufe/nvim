local macchiato = require("catppuccin.palettes").get_palette "macchiato"

require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = {
        -- :h background
        light = "latte",
        dark = "macchiato",
    },
    transparent_background = true,
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.1,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    custom_highlights = {},
    integrations = {
        alpha = true,
        barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
            alt_background = false,
        },
        cmp = true,
        fidget = true,
        harpoon = true,
        headlines = true,
        hop = true,
        illuminate = {
            enabled = true,
            lsp = false
        },
        indent_blankline = {
            enabled = true,
            scope_color = "lavendar",
            colored_indent_levels = false,
        },
        lsp_saga = true,
        lsp_trouble = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
        notify = true,
        nvimtree = true,
        navic = {
            enabled = false,
            custom_bg = "lualine",
        },
        noice = true,
        mason = true,
        rainbow_delimiters = true,
        treesitter = true,
        telescope = true,
        which_key = true,
    },
})

vim.fn.sign_define({
    {
        name = 'DiagnosticSignError',
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = 'ErrorLine',
    },
    {
        name = 'DiagnosticSignWarn',
        text = '',
        texthl = 'DiagnosticSignWarn',
        linehl = 'WarningLine',
    },
    {
        name = 'DiagnosticSignInfo',
        text = '',
        texthl = 'DiagnosticSignInfo',
        linehl = 'InfoLine',
    },
    {
        name = 'DiagnosticSignHint',
        text = '',
        texthl = 'DiagnosticSignHint',
        linehl = 'HintLine',
    },
})

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
