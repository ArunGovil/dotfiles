local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
local function telescope_buffer_dir()
        return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
        defaults = {
                mappings = {
                        n = {
                                ['q'] = actions.close
                        }
                },
                file_ignore_patterns = { "node_modules", "android", "ios" },
        },

        extensions = {
                file_browser = {
                        theme = 'dropdown',
                        hijack_netrw = true,
                        mappings = {
                                ["i"] = {
                                        ["<C-w>"] = function() vim.cmd('normal vbd') end,
                                },
                                ["n"] = {
                                        ["N"] = fb_actions.create,
                                        ["h"] = fb_actions.goto_parent_dir,
                                        ["/"] = function()
                                                vim.cmd('startinsert')
                                        end
                                },
                        },
                }
        }
}

telescope.load_extension('file_browser')

vim.keymap.set('n', ';f',
        function()
                builtin.find_files({
                        no_ignore = false,
                        hidden = false
                })
        end)

vim.keymap.set("n", "sf", function()
        telescope.extensions.file_browser.file_browser({
                path = "%:p:h",
                cwd = telescope_buffer_dir(),
                respect_gitignore = false,
                hidden = true,
                grouped = true,
                previewer = false,
                initial_mode = "normal",
                layout_config = { height = 40 }
        })
end)
