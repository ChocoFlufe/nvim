vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    actions = {
        open_file = { quit_on_open = true },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
    view = {
        adaptive_size = true,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
        custom = { '^.git$', '^node_modules$' }
    },
    git = {
        enable = false
    },
    log = {
        enable = true,
        types = {
            diagnostics = true
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        debounce_delay = 50,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = ''
        }
    },
    on_attach = function(bufnr)
        vim.keymap.set('n', '<c-e>', '<cmd>NvimTreeToggle<cr>',
            { desc = 'toggle', buffer = bufnr, noremap = true, silent = true, nowait = true })
    end
})

vim.keymap.set('n', '<c-e>', '<cmd>NvimTreeToggle<cr>')

require('oil').setup({
    default_file_explorer = false,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ['<c-cr>'] = "actions.select",
    }
})
