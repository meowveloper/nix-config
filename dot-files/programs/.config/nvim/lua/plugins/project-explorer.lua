-- https://github.com/Rics-Dev/project-explorer.nvim.git

return {
    "Rics-Dev/project-explorer.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        paths = { "~/dev/" }, 
        command_pattern = "find %s -mindepth %d -maxdepth %d -type d -not -name '.git'",
        newProjectPath = "~/dev/",
        file_explorer = function(dir)
        end,
    },
    config = function(_, opts)
        require("project_explorer").setup(opts)
    end,
    keys = {
        { "<leader>fp", "<cmd>ProjectExplorer<cr>", desc = "Project Explorer" },
    },
    lazy = false,
}
