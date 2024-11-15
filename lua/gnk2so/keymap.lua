function ToggleTerminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_win_close(win, true)
          return
        end
      end
    end
  end
  vim.cmd('belowright split | terminal')
  vim.defer_fn(function()
    vim.cmd('startinsert')
  end, 100)
end


vim.api.nvim_set_keymap('n', '<C-t>', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:lua ToggleTerminal()<CR>', { noremap = true, silent = true })

