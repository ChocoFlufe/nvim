local actions = require("telescope.actions")
local vimgrep_arguments = { unpack(require('telescope.config').values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")

table.insert(vimgrep_arguments, "!**/.git/*")

require('telescope').setup {
    defaults = {
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {
            '%.o',
            '%.bin',
            '%.cache',
            '%.out',
            '%.class',
            '%.pdf',
            '%.mkv',
            '%.mp4',
            '%.zip',
        },
        -- layout_strategy = 'minimal',
        -- layout_config = {
        --     minimal = {
        --         prompt_position = 'top',
        --         prompt_min_width = 20,
        --         prompt_max_width = 100,
        --         preview_width = 100,
        --         results_border = true,
        --     },
        -- },
        path_display = { 'smart' },
        mappings = {
            i = {
                ["<C-j>"] = actions.preview_scrolling_up,
                ["<C-k>"] = actions.preview_scrolling_down,
                ["<esc>"] = actions.close,
            }
        }
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
    layout_config = {
        horizontal = {
            preview_cutoff = 100,
            preview_width = 0.6
        }
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown()
        }
    }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("vim_bookmarks")
-- require('telescope').load_extension('minimal_layout')
