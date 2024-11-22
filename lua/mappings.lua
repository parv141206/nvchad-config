require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", "<C-k>", function()
  local term_id = "floatTerm"

  -- Check if the terminal is already open
  if vim.tbl_contains(vim.api.nvim_list_wins(), vim.fn.bufwinid(term_id)) then
    -- If it's open, close it
    require("nvchad.term").close(term_id)
  else
    -- If it's closed, open it
    require("nvchad.term").toggle {
      pos = "float",
      id = term_id,
      float_opts = {
        relative = "editor",
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
      }
    }
  end
end, { desc = "Toggle floating terminal" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.wo.number = false
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
