return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_create_enabled = true,
    suppressed_dirs = { "~/" },
    session_lens = {
      picker = "telescope",
      load_on_setup = true,
      theme = "dropdown",
      theme_conf = { border = true },
      previewer = false,
    }
  },
}
