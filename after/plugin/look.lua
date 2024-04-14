require('alpha').setup(require('alpha.themes.dashboard').config)

vim.cmd('highlight IndentBlankLineIndent1 guifg=#494d64 gui=nocombine')
vim.cmd('highlight IndentBlankLineContextChar guifg=#939ab7 gui=nocombine')

require('ibl').setup({
    scope = {
        enabled = false
    }
})

require('illuminate').configure()

require('notify').setup({
    background_colour = '#000000',
})

require("barbecue").setup({
    create_autocmd = false,
    theme = 'catppuccin',
})

require("nvim-navic").setup {
    highlight = true
}

vim.api.nvim_create_autocmd({
    "WinScrolled",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
}, {
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
        require("barbecue.ui").update()
    end,
})

require('colorizer').setup()

require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },
    views = {
        cmdline_popup = {
            position = {
                row = 5,
                col = "50%",
            },
            size = {
                width = 60,
                height = "auto",
            },
            -- border = {
            --     style = "none",
            --     padding = { 2, 3 },
            -- },
            -- filter_options = {},
            -- win_options = {
            --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            -- },
        },
        popupmenu = {
            relative = "editor",
            position = {
                row = 8,
                col = "50%",
            },
            size = {
                width = 60,
                height = 10,
            },
            border = {
                style = "rounded",
                padding = { 0, 1 },
            },
            win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
        },
    },
})

require('lualine').setup {
    options = {
        theme = "catppuccin"
    },
    -- sections = {
    --     lualine_c = {
    --         require('auto-session.lib').current_session_name,
    --     },
    -- },
}

require('headlines').setup()
require('statuscol').setup()
require('twilight').setup()

-- require('bufferline').setup({
--     options = {
--         style_preset = require('bufferline').style_preset.minimal,
--         separator_style = 'slope',
--         hover = {
--             enabled = true,
--             delay = 200,
--             reveal = { 'close' },
--         },
--         diagnostics_indicator = function(count, level, _, _)
--             local icon = level:match("error") and " " or " "
--             return " " .. icon .. count
--         end,
--         numbers = 'ordinal',
--         highlights = require("catppuccin.groups.integrations.bufferline").get(),
--     },
-- })
