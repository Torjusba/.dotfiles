vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        -- print("LspAttach")
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


--[[
--local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, server in ipairs(require('mason-lspconfig').get_installed_servers()) do
    local _config = {
        capabilities = lsp_capabilities
    }
    --if server_name == "clangd" then
        --_config.cmd = {
            --"clangd",
            --"--compile-commands-dir=.",
            --"--suggest-missing-includes",
            --"--query-driver=/usr/bin/**",
            ---- "--query-driver=/usr/bin/arm-none-eabi-g++",
        --}
    --end
    vim.lsp.config(server).setup { _config }
end
    ]]--

require("mason-lspconfig").setup()


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        -- { name = 'buffer' },
    }
})
