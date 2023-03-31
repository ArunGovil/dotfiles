vim.g.mapleader = ";" -- Leader Key
vim.keymap.set("n", "<leader>d", vim.cmd.Ex) -- Open Explorer
vim.keymap.set("n", "<leader>dd", vim.cmd.Rex) -- Close Explorer
vim.keymap.set("n", "<leader>y", '"+y') -- Yank to Clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>a", "ggVG") -- Select all
vim.keymap.set("n", "<leader>s", "G") -- Move to End
vim.keymap.set("n", "<leader>w", "gg") -- Move to Start
vim.keymap.set("n", "<leader>e", "$") -- Line end
vim.keymap.set("n", "<leader>q", "^") -- Line start
vim.keymap.set("n", "<leader>c", vim.cmd.noh) -- Clear find
vim.keymap.set("n", "<leader>x", '"_dd') -- Delete without yank
vim.keymap.set("n", "<leader>r", "cgn") -- Replace text
