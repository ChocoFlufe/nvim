-- require('auto-session').setup({
--     log_level = 'error',
--     auto_session_suppress_dirs = { '~/', '~/proj', '~/Downloads', '/' },
--     bypass_session_save_file_types = nil,
--     cwd_change_handling = {
--         restore_upcoming_session = true,
--         pre_cwd_changed_hook = nil,
--         post_cwd_changed_hook = function()
--             require('lualine').refresh()
--         end,
--         auto_session_enable_last_session = true,
--     },
-- })
