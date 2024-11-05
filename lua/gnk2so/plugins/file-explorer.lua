local function rebind_keymaps(bufnr)
  require("nvim-tree.api").config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "a", function ()
    vim.cmd("silent! lua require('nvim-tree.api').fs.create()")
  end, opts("Create file"))

  vim.keymap.set("n", "d", function ()
    vim.cmd("silent! lua require('nvim-tree.api').fs.remove()")
  end, opts("Delete file"))

  vim.keymap.set("n", "r", function()
    vim.cmd("silent! lua require('nvim-tree.api').fs.rename()")
  end, opts("Rename file"))
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        notify = {
          threshold = vim.log.levels.ERROR
        },
        update_focused_file = {
          enable = true,
        },
        view = {
          adaptive_size = true,
        },
        renderer = {
          group_empty = true,
          highlight_git = "name",
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              item = "│ ",
              none = "  ",
            },
          },
          icons = {
            show = {
              git = false
            }
          }
        },
        on_attach = function (buffrn)
          rebind_keymaps(buffrn)
        end
      })
      vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- Toggle nvim-tree
    end
  }
}
