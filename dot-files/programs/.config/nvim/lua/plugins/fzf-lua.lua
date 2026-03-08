-- https://github.com/ibhagwan/fzf-lua.git
return {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "Find Live Grep",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "Find Buffers",
        },
        {
            "<leader>fx",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "Find Diagnostics Document",
        },
        {
            "<leader>fX",
            function()
                require("fzf-lua").diagnostics_workspace()
            end,
            desc = "Find Diagnostics WorkSpace",
        },
    },
    opts = {},
}
