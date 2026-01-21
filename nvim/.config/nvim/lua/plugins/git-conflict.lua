require('git-conflict').setup({
  default_mappings = true,
  default_commands = true,
  highlights = {
    incoming = 'DiffAdd',
    current = 'DiffText',
  }
})
