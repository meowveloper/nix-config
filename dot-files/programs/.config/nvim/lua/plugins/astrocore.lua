-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing


---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
      },
    },
    mappings = {
      n = {
        ["<Leader>bl"] = { function() require("telescope.builtin").buffers() end, desc = "List Buffers" },
        ["<S-h>"] = { function() require("astrocore.buffer").nav(-1) end, desc = "Previous Buffer" },
        ["<S-l>"] = { function() require("astrocore.buffer").nav(1) end, desc = "Next Buffer" },
        ["[b"] = false,
        ["]b"] = false,
      },
    },
  },
}
