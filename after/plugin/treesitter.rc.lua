local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
        highlight = {
                enable = true,
                disable = {},
        },
        indent = {
                enable = true,
                disable = {},
        },
        ensure_installed = {
                "tsx",
                "json",
                "yaml",
                "css",
                "html",
                "lua",
                "vue"
        },
        autotag = {
                enable = true,
        },
}
