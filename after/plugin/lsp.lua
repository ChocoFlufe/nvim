local lspsaga = require('lspsaga')
local navbuddy = require("nvim-navbuddy")
local wk = require('which-key')

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'tsserver',
    },
})
local capabilites = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    navbuddy.attach(client, bufnr)

    local opts = { buffer = bufnr, noremap = false }
    wk.register({
        ['<leader>k'] = { '<cmd>Lspsaga hover_doc<CR>', 'Hover', opts },
        ['gd'] = { '<cmd>Lspsaga peek_definition<cr>', 'Peek Definition', opts },
        ['gD'] = { '<cmd>Lspsaga peek_declaration<cr>', 'Peek Declaration', opts },
        ['gr'] = { '<cmd>Lspsaga lsp_finder<CR>', 'References', opts },
        ['gi'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Peek Declaration', opts },
        ['gs'] = { '<cmd>Navbuddy<cr>', 'Symbol List', opts },
        ['[d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Next Diagnostic', opts },
        [']d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous Diagnostic', opts },
        ['<leader>ra'] = { '<cmd>Lspsaga code_action<cr>', 'Code Action', opts },
        ['<leader>rn'] = { '<cmd>Lspsaga rename<cr>', 'Rename', opts },
        ['<leader>rs'] = { '<cmd>lua vim.lsp.buf.document_symbol()<cr>', 'Document Symbols', opts },
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end

lspsaga.setup({
    ui = {
        border = 'rounded',
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
})


local lsp_config = {
    capabilites = capabilites,
    on_attach = on_attach,
}

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(lsp_config)
    end,
    ['lua_ls'] = function()
        lspconfig.lua_ls.setup(vim.tbl_extend('force', lsp_config, {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        }))
    end,
    tsserver = function()
        require('typescript').setup({
            server = vim.tbl_extend('force', lsp_config, {
                on_attach = function(_, bufnr)
                    on_attach(_, bufnr)
                end,
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'project=relative',
                        jsxAttributeCompletionStyle = 'none'
                    }
                }
            })
        })
    end,
    lspconfig.lemminx.setup({}),
})

vim.diagnostic.config({
    virtual_text = true
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = cmp.config.sources({
        {
            name = 'nvim_lsp',
            entry_filter = function(entry)
                return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
            end
        },
        { name = 'path' },
        {
            name = 'buffer',
            keyword_length = 3,
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end,
        },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'nvim_lua' },
        {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
        },
        { name = 'plugins' },
        { name = 'fish' },
        { name = 'treesitter' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'calc' },
        { name = 'nvim_lsp_signature_symbol' },
        { name = 'crates' },
    }),
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(cmp_select)
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.mapping.confirm()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(cmp_select)
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<cr>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
        }),
        ['<c-space>'] = cmp.mapping.complete(),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = function(entry, vim_item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
                local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                end
            end
            return lspkind.cmp_format({ with_text = true })(entry, vim_item)
        end
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers["*"]
                }
            },
        },

    })
)

luasnip.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
})

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local d = luasnip.dynamic_node
local sn = luasnip.snippet_node

luasnip.add_snippets('typescriptreact', {
    s('log', {
        t('console.log('),
        i(1, ''),
        t(','),
        i(2, ''),
        t(')'),
    }),
    s('rc', {
        t('export type '),
        i(1),
        t('Props = {}'),
        t({ '', 'export function ' }),
        d(2, function(args)
            -- the returned snippetNode doesn't need a position; it's inserted
            -- "inside" the dynamicNode.
            return sn(nil, {
                -- jump-indices are local to each snippetNode, so restart at 1.
                i(1, args[1]),
            })
        end, { 1 }),
        t('(){return null}'),
    }),
})

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
    },
})

require('cmp-plugins').setup({
    files = { '~/.config/nvim/lua/orca/plugins.lua' }
})

require('fidget').setup({
    window = {
        blend = 0,
    },
})
require('crates').setup()

local rt = require('rust-tools')
local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rt.setup({
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    capabilites = require('cmp_nvim_lsp').default_capabilities(),
    server = {
        on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, noremap = false }
            wk.register({
                ['<leader>k'] = { '<cmd>Lspsaga hover_doc<CR>', 'Hover', opts },
                ['<leader>ra'] = { '<cmd>Lspsaga code_action<cr>', 'Code Action', opts },
            })
        end,
    },
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
})
