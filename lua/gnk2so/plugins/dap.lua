return {
  {
    "mfussenegger/nvim-dap",
    config = function ()
      local dap = require('dap')
      dap.configurations.java = {
        {
          type = 'java';
          request = 'attach';
          name = "Debug (Attach) - Remote";
          hostName = "127.0.0.1";
          port = 5005;
        },
      }
      vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<F5>', function() dap.continue() end)
      vim.keymap.set('n', '<F10>', function() dap.step_over() end)
      vim.keymap.set('n', '<F11>', function() dap.step_into() end)
      vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            size = 40,
            position = "right",
            elements = {
              { id = "scopes", size = 0.5 },
              { id = "stacks", size = 0.5 },
            }
          },
          {
            size = 10,
            position = "bottom",
            elements = {
              { id = "console", size = 1 },
            }
          }
        },
        floating = {
          max_height = 0.8,
          max_width = 0.5,
          border = "rounded",
        },
        windows = { indent = 1 },
      })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      vim.api.nvim_set_keymap("n", "<leader>du", ":lua require(\"dapui\").toggle()<CR>", { noremap = true, silent = true })
    end
  }
}
