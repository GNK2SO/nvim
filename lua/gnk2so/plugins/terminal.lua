return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function ()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]],
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.3
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        end
      end,
    })
    vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
  end
}
