return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensured_installed = {
          "typescript-language-server",
          "jdtls",
          "lua_ls",
          "clangd"
        }
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.jdtls.setup({})
      lspconfig.clangd.setup({})
    end
  },
  { "mfussenegger/nvim-jdtls" },
}
