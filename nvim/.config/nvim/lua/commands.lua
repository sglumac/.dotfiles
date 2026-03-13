-- Diagnostic commands
vim.api.nvim_create_user_command('DiagnosticNext', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Jump to next diagnostic' })

vim.api.nvim_create_user_command('DiagnosticPrev', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Jump to previous diagnostic' })

vim.api.nvim_create_user_command('DiagnosticToggle', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  print('Diagnostics: ' .. (vim.diagnostic.is_enabled({ bufnr = 0 }) and 'ON' or 'OFF'))
end, { desc = 'Toggle diagnostics in current buffer' })

vim.api.nvim_create_user_command('DiagnosticYank', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local diags = vim.diagnostic.get(bufnr, { lnum = row - 1 })
  if #diags == 0 then
    vim.notify("No diagnostics on this line", vim.log.levels.INFO)
    return
  end
  local text = diags[1].message
  vim.fn.setreg('+', text)
  vim.notify("Diagnostic copied to clipboard", vim.log.levels.INFO)
end, { desc = 'Copy diagnostic under cursor to clipboard' })

-- Clipboard commands
vim.api.nvim_create_user_command('YankFilePath', function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg('+', path)
  print("Copied: " .. path)
end, { desc = 'Copy file path to clipboard' })

vim.api.nvim_create_user_command('YankMessages', function()
  vim.fn.setreg("+", vim.fn.execute("messages"))
end, { desc = 'Copy messages to clipboard' })

-- Toggle commands
vim.api.nvim_create_user_command('ToggleVirtualEdit', function()
  if vim.o.virtualedit == "all" then
    vim.opt.virtualedit = ""
  else
    vim.opt.virtualedit = "all"
  end
end, { desc = 'Toggle virtualedit' })

-- DAP commands (supplements built-in DapContinue, DapStepOver, etc.)
vim.api.nvim_create_user_command('DapRunLast', function()
  local dap = require('dap')
  local ft = vim.bo.filetype
  local configs = dap.configurations[ft]
  if not configs or #configs == 0 then
    return vim.notify("No DAP configurations for filetype: " .. ft, vim.log.levels.WARN)
  end
  local last = configs[#configs]
  dap.run(last)
end, { desc = 'Re/start last DAP config' })

vim.api.nvim_create_user_command('DapStackUp', function()
  require('dap').up()
end, { desc = 'DAP stack up' })

vim.api.nvim_create_user_command('DapStackDown', function()
  require('dap').down()
end, { desc = 'DAP stack down' })

vim.api.nvim_create_user_command('DapClearBreakpoints', function()
  require('dap').clear_breakpoints()
end, { desc = 'Clear all DAP breakpoints' })
