return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          -- 🛠 CMake Linter
          null_ls.builtins.diagnostics.cmake_lint.with({
            command = "cmake-lint",
            args = { "--suppress-decorations" },            -- Adjust flags as needed
            filetypes = { "cmake" },
            method = null_ls.methods.DIAGNOSTICS_ON_CHANGE, -- Enable real-time linting
            -- diagnostics_format = "#{m} [#{c}]", -- Show warning/error codes
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.WARN
            end,
          }),
          -- 🛠 CMake Formatter
          null_ls.builtins.formatting.cmake_format.with({
            command = "cmake-format",
            args = { "-" },
          }),

          -- 🛠 C++ Linter (Clang-Tidy)
          --                null_ls.builtins.diagnostics.clang_check.with({
          --                    command = "clang-tidy",
          --                    args = { "--quiet", "--warnings-as-errors=*", "--header-filter=.*" },
          --                }),

          -- 🛠 C++ Formatter (Clang-Format)
          null_ls.builtins.formatting.clang_format.with({
            command = "clang-format",
            args = { "--style=file" }, -- Uses `.clang-format` in project root
          }),

          -- 🛠 Lua Linter: luacheck
          --        null_ls.builtins.diagnostics.luacheck.with({
          --            command = "luacheck",
          --            args = { "--formatter", "plain", "--codes", "--ranges", "--no-color", "-" },
          --            extra_args = { "--globals", "vim" }, -- Allow 'vim' as a global variable
          --            diagnostics_format = "[#{c}] #{m} (#{s})",
          --        }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- Use the native Neovim formatting call
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end
      })

      -- Keybinding for manual formatting
      vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, { noremap = true, silent = true })
    end,
  }
}
