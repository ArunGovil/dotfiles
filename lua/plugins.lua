local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("lazy").setup({
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					globalstatus = true,
					component_separators = "▏", --"┃",
					section_separators = "",
					refresh = { statusline = 50 },
				},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
	{ "lewis6991/gitsigns.nvim", version = "*", config = true },
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs", version = "*", config = true },
	{ "windwp/nvim-ts-autotag", version = "*", config = true },
	{ "BurntSushi/ripgrep" },
	{ "nvim-treesitter/nvim-treesitter", version = "*", config = true },
	{ "nvim-telescope/telescope.nvim", version = "*", config = true },
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					gopls = { "prettier" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>F", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local keymap = vim.keymap
			local capabilities = cmp_nvim_lsp.default_capabilities()
			local opts = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				opts.buffer = bufnr

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>R", ":LspRestart<CR>", opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<leader>[", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<leader>]", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "<leader>;", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Show LSP references"
				keymap.set("n", "<leader>'", "<cmd>Telescope lsp_references<CR>", opts)
			end

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			lspconfig["html"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["cssls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["gopls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { -- custom settings for lua
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		version = "*",
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
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(), -- close completion window
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- lsp suggestions
					{ name = "luasnip" }, -- snippets
					{ name = "buffer" }, -- text within current buffer
					{ name = "path" }, -- file system paths
				}),
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"ts_ls",
					"html",
					"cssls",
					"lua_ls",
					"gopls",
				},
				automatic_installation = true, -- not the same as ensure_installed
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"eslint_d", -- js linter
				},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {},
		config = function()
			require("nvim-tree").setup({
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
					indent_markers = {
						enable = true,
					},
					icons = {
						webdev_colors = false,
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
						},
					},
				},
				diagnostics = {
					enable = true,
				},
				git = {
					enable = true,
				},
			})
		end,
	},
})

vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_create_autocmd({ "QuitPre" }, {
	callback = function()
		vim.cmd("NvimTreeClose")
	end,
})
