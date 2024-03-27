local lspsaga = require('lspsaga')
local navbuddy = require("nvim-navbuddy")
local wk = require('which-key')

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'tsserver',
        'omnisharp_mono',
        'clangd',
    },
})
local capabilites = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    navbuddy.attach(client, bufnr)

    local opts = { buffer = bufnr, noremap = false }
    wk.register({
        ['<leader>k'] = { '<cmd>Lspsaga hover_doc<cr>', 'Hover', opts },
        ['gd'] = { '<cmd>Lspsaga peek_definition<cr>', 'Peek Definition', opts },
        ['gD'] = { '<cmd>Lspsaga goto_definition<cr>', 'Go to Definition', opts },
        ['gr'] = { '<cmd>Lspsaga finder ref<CR>', 'References', opts },
        ['gi'] = { '<cmd>Lspsaga finder imp<CR>', 'Implementations', opts },
        ['gs'] = { '<cmd>Navbuddy<cr>', 'Symbol List', opts },
        ['[d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Next Diagnostic', opts },
        [']d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous Diagnostic', opts },
        ['<leader>ra'] = { '<cmd>Lspsaga code_action<cr>', 'Code Action', opts },
        ['<leader>rn'] = { '<cmd>Lspsaga rename<cr>', 'Rename', opts },
        ['<leader>b'] = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format', opts },
        ['<leader>xq'] = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble View', opts },
        ['<c-s-j>'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature', opts },
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
    ['omnisharp'] = function()
        lspconfig.omnisharp.setup(vim.tbl_extend('force', lsp_config, {
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            cmd = { "omnisharp-mono", '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
        }))
    end,
    ['clangd'] = function()
        lspconfig.clangd.setup(vim.tbl_extend('force', lsp_config, {
            capabilities = {
                offsetEncoding = 'utf-16',
            },
            on_attach = function(_, bufnr)
                local opts = { buffer = bufnr, noremap = false }
                wk.register({
                    ['<leader>vh'] = { '<cmd>ClangdSwitchSourceHeader<cr>', 'Switch source header file', opts },
                    ['<leader>k'] = { '<cmd>Lspsaga hover_doc<cr>', 'Hover', opts },
                    ['gd'] = { '<cmd>Lspsaga peek_definition<cr>', 'Peek Definition', opts },
                    ['gD'] = { '<cmd>Lspsaga goto_definition<cr>', 'Go to Definition', opts },
                    ['gr'] = { '<cmd>Lspsaga finder ref<CR>', 'References', opts },
                    ['gi'] = { '<cmd>Lspsaga finder imp<CR>', 'Implementations', opts },
                    ['gs'] = { '<cmd>Navbuddy<cr>', 'Symbol List', opts },
                    ['[d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Next Diagnostic', opts },
                    [']d'] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous Diagnostic', opts },
                    ['<leader>ra'] = { '<cmd>Lspsaga code_action<cr>', 'Code Action', opts },
                    ['<leader>rn'] = { '<cmd>Lspsaga rename<cr>', 'Rename', opts },
                    ['<leader>t'] = { '<cmd>Lspsaga term_toggle<cr>', 'Toggle Floating Terminal', opts },
                    ['<leader>b'] = { '<cmd>lua vim.lsp.buf.format()<cr>', 'Format', opts },
                    ['<leader>xq'] = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble View', opts },
                    ['<leader>tt'] = { '<cmd>Lspsaga term_toggle', 'Toggle Terminal', opts },
                    ['<c-s-j>'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature', opts },

                })
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end
                })
            end,
            cmd = { 'clangd', '--enable-config', '--background-index' }
        }))
    end,
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
            -- if vim.tbl_contains({ 'path' }, entry.source.name) then
            --     local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
            --     if icon then
            --         vim_item.kind = icon
            --         vim_item.kind_hl_group = hl_group
            --         return vim_item
            --     end
            -- end
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

luasnip.add_snippets('all', {
    s('INCLUDE', {
        d(1, function(args, snip)
            -- Create a table of nodes that will go into the header choice_node
            local headers_to_load_into_choice_node = {}

            -- Step 1: get companion .h file if the current file is a .c or .cpp file excluding main.c
            local extension = vim.fn.expand('%:e')
            local is_main = vim.fn.expand('%'):match('main%.cp?p?') ~= nil
            if (extension == 'c' or extension == 'cpp') and not is_main then
                local matching_h_file = vim.fn.expand('%:t'):gsub('%.c', '.h')
                local companion_header_file = string.format('#include "%s"', matching_h_file)
                table.insert(headers_to_load_into_choice_node, t(companion_header_file))
            end

            -- Step 2: get all the local headers in current directory and below
            local current_file_directory = vim.fn.expand('%:h')
            local local_header_files = require('plenary.scandir').scan_dir(
                current_file_directory,
                { respect_gitignore = true, search_pattern = '.*%.h$' }
            )

            -- Clean up and insert the detected local header files
            for _, local_header_name in ipairs(local_header_files) do
                -- Trim down path to be a true relative path to the current file
                local shortened_header_path = local_header_name:gsub(current_file_directory, '')
                -- Replace '\' with '/'
                shortened_header_path = shortened_header_path:gsub([[\+]], '/')
                -- Remove leading forward slash
                shortened_header_path = shortened_header_path:gsub('^/', '')
                local new_header = t(string.format('#include "%s"', shortened_header_path))
                table.insert(headers_to_load_into_choice_node, new_header)
            end

            -- Step 3: allow for custom insert_nodes for local and system headers
            local custom_insert_nodes = {
                sn(
                    nil,
                    fmt(
                        [[
                         #include "{}"
                         ]],
                        {
                            i(1, 'custom_insert.h'),
                        }
                    )
                ),
                sn(
                    nil,
                    fmt(
                        [[
                         #include <{}>
                         ]],
                        {
                            i(1, 'custom_system_insert.h'),
                        }
                    )
                ),
            }
            -- Add the custom insert_nodes for adding custom local (wrapped in "") or system (wrapped in <>) headers
            for _, custom_insert_node in ipairs(custom_insert_nodes) do
                table.insert(headers_to_load_into_choice_node, custom_insert_node)
            end

            -- Step 4: finally last priority is the system headers
            local system_headers = {
                t('#include <assert.h>'),
                t('#include <complex.h>'),
                t('#include <ctype.h>'),
                t('#include <errno.h>'),
                t('#include <fenv.h>'),
                t('#include <float.h>'),
                t('#include <inttypes.h>'),
                t('#include <iso646.h>'),
                t('#include <limits.h>'),
                t('#include <locale.h>'),
                t('#include <math.h>'),
                t('#include <setjmp.h>'),
                t('#include <signal.h>'),
                t('#include <stdalign.h>'),
                t('#include <stdarg.h>'),
                t('#include <stdatomic.h>'),
                t('#include <stdbit.h>'),
                t('#include <stdbool.h>'),
                t('#include <stdckdint.h>'),
                t('#include <stddef.h>'),
                t('#include <stdint.h>'),
                t('#include <stdio.h>'),
                t('#include <stdlib.h>'),
                t('#include <stdnoreturn.h>'),
                t('#include <string.h>'),
                t('#include <tgmath.h>'),
                t('#include <threads.h>'),
                t('#include <time.h>'),
                t('#include <uchar.h>'),
                t('#include <wchar.h>'),
                t('#include <wctype.h>'),
            }
            for _, header_snippet in ipairs(system_headers) do
                table.insert(headers_to_load_into_choice_node, header_snippet)
            end

            return sn(1, c(1, headers_to_load_into_choice_node))
        end, {}),
    }),
})

luasnip.filetype_extend("lua", { "c" })
luasnip.filetype_set("cpp", { "c" })
require("luasnip.loaders.from_lua").load({ include = { "c" } })
require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp" } })

-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--     sources = {
-- null_ls.builtins.formatting.prettierd,
-- null_ls.builtins.diagnostics.clang_check.with({
--     filetypes = { 'c', 'cpp', 'h', 'hpp' },
-- }),
-- null_ls.builtins.formatting.clang_format.with({
--     filetypes = { 'c', 'cpp', 'h', 'hpp' },
-- }),
--     },
-- })


-- local ft = require('guard.filetype')
-- ft('c,cpp,h'):fmt('clang-format')
--     :lint('clang-tidy')
--
-- require('guard').setup({
--     fmt_on_save = true,
--     lsp_as_default_formatter = false,
-- })
--
-- require('cmp-plugins').setup({
--     files = { '~/.config/nvim/lua/orca/plugins.lua' }
-- })

-- require('fidget').setup({
--     window = {
--         blend = 0,
--     },
-- })
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
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
})
