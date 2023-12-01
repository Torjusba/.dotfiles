print("Got this far")
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        print("LspAttach")
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vD", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true} end, opts)
    end
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
    }
})

local lspconfig = require('lspconfig')


local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason-lspconfig').setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
        })
    end,
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})

--[[
lsp.configure('lua_ls', {
settings = {
Lua = {
diagnostics = {
globals = { 'vim' }
}
}
}
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
['<C-y>'] = cmp.mapping.confirm({ select = true }),
['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
--print("LSP attached")
local opts = {buffer = bufnr, remap = false}

vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vD", function() vim.lsp.buf.type_definition() end, opts)
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true} end, opts)
end)

lsp.setup()

vim.diagnostic.config({
virtual_text = true
})

require('lspconfig.configs').templ = {
default_config = {
cmd = {"templ", "lsp"},
filetypes = {"templ"},
root_dir = require('lspconfig').util.root_pattern("go.mod"),
settings = {},
};
}
require("lspconfig").templ.setup({})
]]--
