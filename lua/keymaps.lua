local options = { silent = true, noremap = true }

vim.g.mapleader = ";" -- Leader Key
vim.keymap.set("n", "<leader>d", ":NvimTreeFindFile<CR>") -- Open Nvim Tree with current buffer
vim.keymap.set("n", "<leader>l", ":NvimTreeToggle<CR>") -- Toggle Nvim Tree
vim.keymap.set("n", "<leader>y", '"+y') -- Yank to Clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>a", "ggVG") -- Select all
vim.keymap.set("n", "<leader>s", "G") -- Move to End
vim.keymap.set("n", "<leader>w", "gg") -- Move to Start
vim.keymap.set("n", "<leader>e", "$") -- Line end
vim.keymap.set("n", "<leader>q", "^") -- Line start
vim.keymap.set("n", "q", "b", { noremap = true }) -- Move one word back
vim.keymap.set("n", "<leader>c", vim.cmd.noh) -- Clear find
vim.keymap.set("n", "<leader>x", '"_dd') -- Delete without yank
vim.keymap.set("n", "<leader>r", "cgn") -- Replace text
vim.keymap.set("n", "<leader>z", ":vsplit<CR>", { noremap = true }) -- Split pane vertical
vim.keymap.set("n", "<leader>,", ":split<CR>", { noremap = true }) -- Split pane horizontal
vim.keymap.set("n", "<leader><Tab>", "<C-w>l", { noremap = true }) -- Move to right pane
vim.keymap.set("n", "<leader>k", "<C-w>k", { noremap = true }) -- Move to top pane
vim.keymap.set("n", "<leader>\\", "<C-w>h", { noremap = true }) -- Move to left pane
vim.keymap.set("n", "<leader>j", "<C-w>j", { noremap = true }) -- Move to bottom pane
vim.keymap.set("n", "<leader>f", [[<cmd>Telescope find_files<cr>]], { noremap = true, silent = true }) -- Find files
vim.keymap.set("n", "<leader>g", [[<cmd>Telescope live_grep<cr>]], { noremap = true, silent = true }) -- Live grep
vim.keymap.set("n", "<leader>b", [[<cmd>Telescope buffers<cr>]], { noremap = true, silent = true }) -- Find buffers
vim.keymap.set("n", "<leader>v", "<C-v>", { noremap = true }) -- Select line mode for comments
vim.keymap.set("n", "<leader>t", ":botright 56vsplit term://zsh<CR>", options) -- Open terminal
vim.keymap.set("n", "<leader>p", ":Neogit kind=vsplit<CR>", options) -- Open git
-- Escape editing mode in terminal
vim.api.nvim_exec(
	[[
  tnoremap <Esc> <C-\><C-n>
]],
	false
)
