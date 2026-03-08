return {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
	{ "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
	{
	    "<leader>e",
	    mode = { "n", "v" },
	    "<cmd>Yazi<cr>",
	    desc = "Open yazi at the current file",
	},
	{
	    "<leader>ew",
	    mode = { "n", "v" },
	    "<cmd>Yazi cwd<cr>",
	    desc = "Open yazi at the current working directory",
	},
    },

    ---@type YaziConfig | {}
    opts = {
	open_for_directories = false,
	keymaps = {
	    show_help = "<f1>",
	},
    },

    init = function()
	vim.g.loaded_netrwPlugin = 1
    end
}
