local status, lualine = pcall(require, 'lualine')
if (not status) then return end

lualine.setup {
        options = {
                icons_enabled = true,
                theme = 'solarized_dark',
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
        },
        sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { {
                        'filename',
                        file_status = true,
                        path = 0
                } },
        }
}
