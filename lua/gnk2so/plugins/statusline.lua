return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
        section_separators = {"", ""},
        component_separators = {"", ""},
        icons_enabled = true,
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch"},
        lualine_c = {"filename"},
        lualine_x = {"encoding"},
        lualine_y = {"location"},
        lualine_z = {"filetype"},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })

  end
}
