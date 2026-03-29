-- ==========================================
-- title: keymaps
-- about: sets some quality-of-life keymaps
-- ==========================================

-- center seceen when jumping
vim.keymap.set("n", "n", "nzz", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzz", { desc = "previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })

-- buffer navigation
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<S-h>", "<Cmd>bprevious<CR>", { desc = "previous buffer" })
vim.keymap.set("n", "<leader>c", "<Cmd>bdelete<CR>", { desc = "close current buffer" })
vim.keymap.set('n', '<leader>bc', function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            vim.api.nvim_buf_delete(buf, { force = false })
        end
    end
end, { desc = "Close all other buffers" })

--better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "move to top window" })

-- splitting and resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "decrease window height" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "increase window height" })

-- better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })

-- better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })

-- escape insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "escape insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "escape insert mode" })

-- better save
vim.keymap.set("n", "<leader>w", "<Cmd>write<CR>", { desc = "write/save" })

-- Terminal Emulator Settings
vim.keymap.set("n", "<leader>t", "<Cmd>terminal<CR>", { desc = "open terminal in full window" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "exit terminal/insert mode and go back to normal mode" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        -- Navigation
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
        vim.keymap.set("n", "gs", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts) -- go to definition in split
        vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) --  code actions
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- rename symbol
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) --hover documentation

        -- diagnostics
        vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float({ scope = 'line' })<CR>", opts) -- line diagnostics(float)     
        vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- cursor diagnostics(float)     
        vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- goto next diagnostic     
        vim.keymap.set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- goto previous diagnostic     

        -- fzf-lua keymaps
        vim.keymap.set("n", "<leader>lf", "<cmd>FzfLua lsp_finder<CR>", opts) -- Lsp finder (definition + references)     
        vim.keymap.set("n", "<leader>lr", "<cmd>FzfLua lsp_references<CR>", opts) --  show all references to the symbol under the cursor    
        vim.keymap.set("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<CR>", opts) -- jump to the type definition of the symbol under the cursor    
        vim.keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_document_symbols<CR>", opts) -- list all symbols (functions, classes, etc)  
        vim.keymap.set("n", "<leader>lw", "<cmd>FzfLua lsp_workdpace_symbols<CR>", opts) -- search for any symbol across the entire project 
        vim.keymap.set("n", "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", opts) -- go to implementation

    end,
})
