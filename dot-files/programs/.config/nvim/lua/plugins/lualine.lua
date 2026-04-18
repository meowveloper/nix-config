return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '|', right = '|' },
        },
        tabline = {
            lualine_a = {
                {
                    'buffers',
                    show_filename_only = true,
                    hide_filename_extension = false,
                    show_modified_status = true,
                }
            },
        },
    },
}
