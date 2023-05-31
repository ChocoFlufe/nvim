local wk = require('which-key')

require('tabout').setup {
    tabkey = '<c-n>',
    backwards_tabkey = '',
    act_as_tab = true,
    act_as_shift_tab = false,
    default_tab = '<C-t>',
    default_shift_tab = '<C-d>',
    enable_backwards = true,
    completion = true,
    tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '`', close = '`' },
        { open = '(', close = ')' },
        { open = '[', close = ']' },
        { open = '{', close = '}' }
    },
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {} -- tabout will ignore these filetypes
}

require('hop').setup({
    quit_key = '<leader>',
})
wk.register({
    ['f'] = {
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })<cr>',
        'Move Forwards Towards Word', remap = true },
    ['F'] = {
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>',
        'Move Backwards Towards Word', remap = true },
    ['t'] = {
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>',
        'Move Forwards Befores Word', remap = true },
    ['T'] = {
        '<cmd>lua require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>',
        'Move Backwards Befores Word', remap = true },
    ['s'] = {
        '<cmd>lua require("hop").hint_words({ direction = require("hop.hint") })<cr>',
        'Move Backwards Befores Word', remap = true },
})
