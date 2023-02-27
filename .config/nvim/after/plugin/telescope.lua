local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

require('git-worktree').setup({
    change_directory_command = "cd"
})
require('telescope').load_extension('git_worktree')
vim.keymap.set('n', '<leader>gwl', function() require('telescope').extensions.git_worktree.git_worktrees() end)
vim.keymap.set('n', '<leader>gwn', function() require('telescope').extensions.git_worktree.create_git_worktree() end)
