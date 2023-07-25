local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    disable_filetype = { 'TelescopePrompt', 'vim' },
    enable_check_bracket_line = false,
    ignored_next_char = '[%w%.]',
})

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
    Rule('<', '>', 'html')
        :with_move(function()
            return true
        end),
    Rule(' ', ' ')
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
            }, pair)
        end)
}
for _, bracket in pairs(brackets) do
    npairs.add_rules {
        Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
                return opts.prev_char:match('.%' .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2])
    }
end

require('alternate-toggler').setup({
    alternates = {
        ['=='] = '!=',
        ['yes'] = 'no',
    }
})

require('todo-comments').setup()
require('Comment').setup()
require('template-string').setup()

-- require('open').setup()
