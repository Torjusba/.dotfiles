vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>ec", function ()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        vim.cmd('!python %')
    elseif filetype == "rust" then
        vim.cmd('cargo run')
    else
        print("Execute current is not implemented for filetype", vim.bo.filetype)
    end
end)
