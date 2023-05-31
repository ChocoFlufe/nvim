local actions = require("telescope.actions")

require('telescope').setup {
    defaults = {
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
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<esc>"] = actions.close
            }
        }
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
