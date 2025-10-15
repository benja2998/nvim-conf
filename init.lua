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
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    {
        "MagicDuck/grug-far.nvim",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                            regex = true,
                            confirm = true,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace (regex)",
            },
        },
    },
{
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
})

vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h14"
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- Go to definition
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
-- Show references
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
-- Hover info
vim.keymap.set("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true })
-- File explorer
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true })
-- Tab completion in insert mode
vim.keymap.set("i", "<Tab>", 
  [[coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"]],
  { expr = true, silent = true }
)

-- Navigate windows with Ctrl + hjkl
--[[
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
]]

-- Move to next buffer/tab
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true })

-- Move to previous buffer/tab
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { silent = true })

-- Close current buffer
vim.keymap.set("n", "<leader>c", ":bdelete<CR>", { silent = true })

vim.api.nvim_set_keymap('n', '<leader>n', ':tabnew<CR>', { noremap = true, silent = true })

-- nvim-autopairs setup
--[[
require('nvim-autopairs').setup({
    check_ts = true,
    enable_check_bracket_line = true,
    enable_moveright = true,
})
]]

-- Telescope setup
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
            vertical = { mirror = false },
            horizontal = { mirror = false, width = 0.9, height = 0.8 },
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
            n = {
                ["q"] = actions.close,
            },
        },
    },
})

local builtin = require("telescope.builtin")

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
