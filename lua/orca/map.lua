local wk = require('which-key')

vim.g.mapleader = ' '

local opts = {
    buffer = nil,
    silent = true,
    noremap = true,
}
-- Remaps
wk.register({
    ['<leader>w'] = { '<cmd>w!<cr>', 'Write', opts },
    ['<leader>q'] = { '<cmd>q<cr>', 'Exit', opts },
    ['<leader>z'] = { '<cmd>q!<cr>', 'Exit', opts },
    ['<leader>e'] = { '<cmd>w !sudo tee %<cr>', 'Write Sudo', opts },

    ['H'] = { '_', 'Start of Line', opts, mode = { 'n', 'v' } },
    ['L'] = { '$', 'End of Line', opts, mode = { 'n', 'v' } },
    ['J'] = { 'mzJ`z', 'Move Line Below to Current Line', opts, mode = 'n' },
    ['<c-;>'] = { '<esc>$a;', 'Insert Semi-Colon At End Of Line', opts, mode = { 'n', 'i' } },
    ['<c-,>'] = { '<esc>$a,', 'Insert Comma At End Of Line', opts, mode = { 'n', 'i' } },
    ['<c-j>'] = { "<esc>j$a", 'Go To Next Line', mode = 'i', opts },

    -- ['<c-a>'] = { 'gg<s-v>G', 'Select All', opts },
    ['<c-d>'] = { '<c-d>zz', 'Scroll Down Half A Page', opts },
    ['<c-u>'] = { '<c-u>zz', 'Scroll Up Half A Page', opts },

    ["<c-c>"] = { '"+y', "Copy to system clipboard", mode = 'v' },
    ["<c-v>"] = { '<c-r>+"', "Paste system clipboard", mode = { 'n', 'v' } },

    ['<leader>sh'] = { '<cmd>vsplit<cr><c-w>w', 'Horizontal Split', opts },
    ['<leader>sv'] = { '<cmd>split<cr><c-w>w', 'Vertical Split', opts },
    ['<leader>r'] = { '<c-w>w', 'Switch Split', opts },

    ['n'] = { 'nzzzv', 'Next Search Term', opts },
    ['N'] = { 'Nzzzv', 'Previous Search Term', opts },

    ['<c-j>'] = { '<cmd>cnext<cr>zz', 'Next Quick Fix', mode = 'n', opts },
    ['<c-k>'] = { '<cmd>cprev<cr>zz', 'Previous Quick Fix', opts },
    ['<leader>j'] = { '<cmd>lnext<cr>zz', 'Next Location', opts },
    ['<leader>s'] = { ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Replace', opts },
    ['<leader>xx'] = { '<cmd>!chmod +x %<cr>', 'Mark File as Executable', opts },
    ['<leader><leader>s'] = { '<cmd>so<cr>', 'Source', noremap = true },
    ['<leader><leader>e'] = { '<cmd>e ~/.config/nvim/lua/orca/plugins.lua<cr><cmd>cd ~/.config/nvim/<cr>',
        'Edit Config Files', opts },

    ['J'] = { ":m '>+1<cr>gv=gv", 'Move Selection Down', mode = 'v', opts },
    ['K'] = { ":m '<-2<cr>gv=gv", 'Move Selection Up', mode = 'v', opts },
    ['<leader>tt'] = { '<cmd>Lspsaga term_toggle<cr>', 'Toggle Terminal', opts },
})

-- Telscope
wk.register({
    ['<leader>f'] = { '<cmd>Telescope find_files<cr>', 'Find File', opts },
    ['<leader>g'] = { '<cmd>Telescope live_grep<cr>', 'Live Grep', opts },
    ['<leader>h'] = { '<cmd>Telescope help_tags<cr>', 'Help Tags', opts },
})

-- Alternate Toggler
wk.register({
    ['<leader>ta'] = { '<cmd>ToggleAlternate<cr>', 'Toggle Alternate', opts },
})

-- Bookamarks
wk.register({
    ['ma'] = { '<cmd>Telescope vim_bookmarks<cr>', 'View Booksmarks', opts },
})

-- Opener
wk.register({
    ['gx'] = { '<cmd>lua require("open").open_cword()<cr>', 'Open', opts },
})

-- Zen
wk.register({
    ['<leader>m'] = { '<cmd>Twilight<cr>', 'Enter Zen Mode', opts },
})

-- Buffers
wk.register({
    ['<c-h>'] = { '<cmd>BufferLineCycleNext<cr>', 'Next Buffer', mode = { 'n', 'i', 'v' }, opts },
    ['<c-s-h>'] = { '<cmd>BufferLineMoveNext<cr>', 'Move Buffer to Right', mode = { 'n', 'i', 'v' }, opts },
    ['<c-g>'] = { '<cmd>BufferLineCyclePrev<cr>', 'Previous Buffer', mode = { 'n', 'i', 'v' }, opts },
    ['<c-s-g>'] = { '<cmd>BufferLineMovePrev<cr>', 'Move Buffer to Left', mode = { 'n', 'i', 'v' }, opts },
    ['<c-y>'] = { '<cmd>bd<cr>', 'Delete Buffer', opts },
})

-- Dap
wk.register({
    ['<leader>dt'] = { '<cmd>DapToggleBreakpoint<cr>', 'Toggle Breakpoint', opts },
    ['<leader>dx'] = { '<cmd>DapTerminate<cr>', 'Terminate Debug', opts },
    ['<leader>do'] = { '<cmd>DapStepOver<cr>', 'Step Debug', opts },
})

-- Oil
wk.register({
    ['-'] = { '<cmd>lua require("oil").open()<cr>', 'Open Oil File Explorer', opts },
})

-- Noice
wk.register({
    ['<leader>nd'] = { '<cmd>NoiceDismiss<cr>', 'Dismiss Noice Notification', opts }
})

-- Harpoon
harpoon = require("harpoon")
wk.register({
    ['<leader>a'] = { function() harpoon:list():append() end, 'Append File to Harpoon', opts },
    ['<leader>u'] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, 'List Files in Harpoon', opts },
    ['<leader>1'] = { function() harpoon:list():select(1) end, 'Switch to File 1 in Harpoon', opts },
    ['<leader>2'] = { function() harpoon:list():select(2) end, 'Switch to File 2 in Harpoon', opts },
    ['<leader>3'] = { function() harpoon:list():select(3) end, 'Switch to File 3 in Harpoon', opts },
    ['<leader>4'] = { function() harpoon:list():select(4) end, 'Switch to File 4 in Harpoon', opts },
})
