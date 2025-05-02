return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    -- import dap plugin
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
    keymap.set("n", "<leader>dr", dap.run_last, { silent = true, desc = "Runs debugger" })
    keymap.set("n", "<leader>dc", dap.continue, { silent = true, desc = "Continue" })
    keymap.set("n", "<leader>dl", dap.list_breakpoints, { silent = true, desc = "List breakpoints" })
    keymap.set("n", "<leader>dn", dap.step_over, { silent = true, desc = "Next" })
    keymap.set("n", "<leader>ds", dap.step_into, { silent = true, desc = "Step into" })
    keymap.set("n", "<leader>df", dap.step_out, { silent = true, desc = "Finish" })
    keymap.set("n", "<leader>dq", dap.terminate, { silent = true, desc = "Quit" })

    dap.adapters.lldb = {
      type = "executable",
      command = "/etc/profiles/per-user/ahadisee/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.cpp = dap.configurations.c

    dap.configurations.rust = {
      vim.tbl_deep_extend("force", dap.configurations.c[1], {
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,

        runInTerminal = false,
        initCommands = function()
          -- Find out where to look for the pretty printer Python module.
          local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
          assert(vim.v.shell_error == 0, "failed to get rust sysroot using `rustc --print sysroot`: " .. rustc_sysroot)
          local script_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
          local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
          return {
            ([[!command script import '%s']]):format(script_file),
            ([[command source '%s']]):format(commands_file),
          }
        end,
      }),
    }
  end,
}
