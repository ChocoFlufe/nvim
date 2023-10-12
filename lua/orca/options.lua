local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- Use UTF-8 encoding
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Use 4 spaces for tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.smartindent = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search settings
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Enable mouse and keyboard features
opt.mouse = 'a'
opt.clipboard:append('unnamedplus')
opt.backspace = '2'

-- Swapfile
opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true
opt.updatetime = 50
opt.backup = false

-- Window options
opt.list = true
opt.showcmd = true
opt.laststatus = 2
opt.cursorline = true
opt.termguicolors = true

-- List
opt.list = true
opt.listchars:append 'tab:>> ,trail:~,extends:>,precedes:<,nbsp:·'

-- Sessions
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Misc
opt.timeout = true
opt.timeoutlen = 300
opt.autowrite = true
opt.completeopt = { 'menuone', 'noselect' }
opt.colorcolumn = '9999'
-- vim.api.nvim_command('set autochdir')

-- Set assembly syntax type
autocmd({'BufNew', 'BufRead'}, {
    pattern = '*.asm',
    callback = function()
        vim.api.nvim_command('set ft=nasm')
    end,
})

vim.api.nvim_create_autocmd({'BufNew', 'BufRead'}, {
    pattern = '*.s',
    callback = function()
        vim.api.nvim_command('set ft=asm')
    end,
})

autocmd({'BufNew', 'BufRead'}, {
    pattern = '*.vert',
    callback = function()
        vim.api.nvim_command('set ft=c')
    end,
})

autocmd({'BufNew', 'BufRead'}, {
    pattern = '*.frag',
    callback = function()
        vim.api.nvim_command('set ft=c')
    end,
})
autocmd({'BufNew', 'BufRead'}, {
    pattern = '*.glsl',
    callback = function()
        vim.api.nvim_command('set ft=c')
    end,
})

-- Set line number for help files.
autocmd('FileType', {
    pattern = 'help',
    callback = function()
        opt.number = true
    end,
})

-- Trim Whitespace
autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        vim.api.nvim_exec(
            [[
        function! NoWhitespace()
          let l:save = winsaveview()
          keeppatterns %s/\s\+$//e
          call winrestview(l:save)
        endfunction
        call NoWhitespace()
        ]],
            true
        )
    end,
})
