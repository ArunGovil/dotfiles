-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before loading plugins
vim.g.mapleader = ";"

-- Common keymap options
local opts = { noremap = true, silent = true }

-- LSP on_attach function
local function on_attach(client, bufnr)
	local keymap = vim.keymap
	local buffer_opts = vim.tbl_extend("force", opts, { buffer = bufnr })

	-- LSP keymaps
	keymap.set("n", "<leader>R", ":LspRestart<CR>", vim.tbl_extend("force", buffer_opts, { desc = "Restart LSP" }))
	keymap.set(
		"n",
		"<leader>[",
		vim.diagnostic.goto_prev,
		vim.tbl_extend("force", buffer_opts, { desc = "Go to previous diagnostic" })
	)
	keymap.set(
		"n",
		"<leader>]",
		vim.diagnostic.goto_next,
		vim.tbl_extend("force", buffer_opts, { desc = "Go to next diagnostic" })
	)
	keymap.set(
		"n",
		"<leader>;",
		vim.lsp.buf.hover,
		vim.tbl_extend("force", buffer_opts, { desc = "Show documentation" })
	)
	keymap.set(
		"n",
		"<leader>'",
		"<cmd>Telescope lsp_references<CR>",
		vim.tbl_extend("force", buffer_opts, { desc = "Show LSP references" })
	)
end

-- TypeScript/Flow special attach
local function ts_attach(client, bufnr)
	local has_flowconfig = vim.fn.globpath(client.config.root_dir, ".flowconfig")
	if has_flowconfig ~= "" then
		client.stop()
	else
		on_attach(client, bufnr)
	end
end

-- Plugin specifications
require("lazy").setup({
	-- Color scheme
	{ "blazkowolf/gruber-darker.nvim" },

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			options = {
				icons_enabled = false,
				globalstatus = true,
				component_separators = "▏",
				section_separators = "",
				refresh = { statusline = 50 },
			},
		},
	},

	-- Git integration
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
	{ "lewis6991/gitsigns.nvim", config = true },

	-- Editor enhancements
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs", config = true },
	{ "windwp/nvim-ts-autotag", config = true },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "norcalli/nvim-colorizer.lua", event = "BufEnter", opts = { "*" } },

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim", config = true },

	-- AI assistants
	{ "github/copilot.vim", enabled = false },
	{
		"greggh/claude-code.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			window = {
				split_ratio = 0.3,
				position = "vertical",
				enter_insert = true,
				hide_numbers = true,
				hide_signcolumn = true,
			},
		},
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "yamlfmt" },
				markdown = { "prettier" },
				lua = { "stylua" },
				dart = { "dart_format" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
				end,
				mode = { "n", "v" },
				desc = "Format file or range",
			},
		},
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- LSP server configurations using new vim.lsp.config API
			local configs = {
				html = {
					name = "html",
					cmd = { "vscode-html-language-server", "--stdio" },
					filetypes = { "html" },
					root_markers = { "package.json", ".git" },
					on_attach = on_attach,
				},
				ts_ls = {
					name = "ts_ls",
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
					root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
					on_attach = ts_attach,
				},
				cssls = {
					name = "cssls",
					cmd = { "vscode-css-language-server", "--stdio" },
					filetypes = { "css", "scss", "less" },
					root_markers = { "package.json", ".git" },
					on_attach = on_attach,
				},
				gopls = {
					name = "gopls",
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_markers = { "go.work", "go.mod", ".git" },
					on_attach = on_attach,
				},
				clangd = {
					name = "clangd",
					cmd = { "clangd" },
					filetypes = { "c", "cpp", "objc", "objcpp" },
					root_markers = { "compile_commands.json", ".git" },
					on_attach = on_attach,
				},
				lua_ls = {
					name = "lua_ls",
					cmd = { "lua-language-server" },
					filetypes = { "lua" },
					root_markers = {
						".luarc.json",
						".luarc.jsonc",
						".luacheckrc",
						".stylua.toml",
						"stylua.toml",
						"selene.toml",
						"selene.yml",
						".git",
					},
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				flow = {
					name = "flow",
					cmd = { "npx", "flow", "lsp" },
					filetypes = { "javascript", "javascriptreact" },
					root_markers = { ".flowconfig" },
					on_attach = on_attach,
				},
				dartls = {
					name = "dartls",
					cmd = { "dart", "language-server", "--protocol=lsp" },
					filetypes = { "dart" },
					root_markers = { "pubspec.yaml", ".git" },
					on_attach = on_attach,
				},
			}

			-- Setup all LSP servers with new API
			for _, config in pairs(configs) do
				config.capabilities = capabilities
				vim.lsp.config(config.name, config)
			end
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = { completeopt = "menu,menuone,preview,noselect" },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	-- LSP/Tool installer
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "html", "cssls", "lua_ls", "gopls" },
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = { "prettier", "stylua", "eslint_d" },
			})
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		opts = {
			hijack_netrw = false,
			hijack_cursor = false,
			view = {
				centralize_selection = true,
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 72,
						height = 28,
						row = 2,
						col = 32,
					},
				},
			},
			renderer = {
				add_trailing = true,
				indent_markers = { enable = true },
				icons = {
					webdev_colors = false,
					show = {
						file = false,
						folder = false,
						folder_arrow = false,
					},
				},
			},
			diagnostics = { enable = true },
			git = { enable = true },
		},
	},
})

-- Apply color scheme
vim.cmd.colorscheme("gruber-darker")

-- Auto-close nvim-tree before quitting
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		vim.cmd("NvimTreeClose")
	end,
})

