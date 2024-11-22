vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)
require("menu")
-- For keyboard users
vim.keymap.set("n", "<C-t>", function() require("menu").open("default") end, {})

-- For mouse users (e.g., in NvimTree)
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
require("volt")
require "options"
require "nvchad.autocmds"
vim.schedule(function()
  require "mappings"
end)

-- Define options for the mapping
local opts = { noremap = true, silent = true }

-- Map Escape key to exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], opts)

-- Optionally, map 'jj' or 'kj' to exit terminal mode
vim.api.nvim_set_keymap('t', 'jj', [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap('t', 'kj', [[<C-\><C-n>]], opts)

-- Resize up
vim.api.nvim_set_keymap('n', '<C-S-Up>', ':resize -2<CR>', opts)
-- Resize down
vim.api.nvim_set_keymap('n', '<C-S-Down>', ':resize +2<CR>', opts)
-- Resize left
vim.api.nvim_set_keymap('n', '<C-S-Left>', ':vertical resize -2<CR>', opts)
-- Resize right
vim.api.nvim_set_keymap('n', '<C-S-Right>', ':vertical resize +2<CR>', opts)
