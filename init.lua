vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- highlight current line
vim.opt.cursorline = true

require("lazy").setup({
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"neovim/nvim-lspconfig"},
    { "nvim-lualine/lualine.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "neoclide/coc.nvim", branch = "release" },
    { "ishan9299/nvim-solarized-lua" },
    { "nvim-tree/nvim-tree.lua" },
    { "akinsho/bufferline.nvim" }
})

require("lualine").setup({
    options = {
        theme = "auto", -- picks from current colorscheme
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
})

-- Go to definition
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
-- Show references
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
-- Hover info
vim.keymap.set("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true })
-- Tab completion in insert mode
vim.keymap.set("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true, silent = true })
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, silent = true })

vim.cmd([[colorscheme solarized]])
vim.o.background = "dark"  -- ensures dark variant

-- nvim-tree setup
require("nvim-tree").setup({
    sort_by = "name",
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    git = {
        enable = true,
    },
})

-- Toggle nvim-tree with <leader>e
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Navigate windows with Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

require("bufferline").setup{
    options = {
        numbers = "ordinal",  -- show buffer numbers
        close_command = "bdelete! %d",  -- close buffer
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_close_icon = true,
        separator_style = "slant",
    }
}

-- Move to next buffer/tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })

-- Move to previous buffer/tab
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

-- Close current buffer
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>n', ':tabnew<CR>', { noremap = true, silent = true })

