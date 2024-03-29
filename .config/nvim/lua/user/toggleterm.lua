require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal

-- lazygit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _lazygit_toggle()
  lazygit:toggle()
end

-- htop
local htop = Terminal:new({ cmd = "htop", hidden = true })
function _htop_toggle()
  htop:toggle()
end
