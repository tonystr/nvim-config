local is_windows = vim.uv.os_uname().sysname == 'Windows'
local config_path = vim.fn.stdpath'config'

-- Global variables
vim.env.MYVIMRC       = config_path .. '/init.lua'
vim.env.INIT          = config_path .. '/init.lua'
vim.env.COLORS        = config_path .. '/lua/colors.lua'
vim.env.MAPPINGS      = config_path .. '/lua/mappings.lua'
vim.env.PREFERENCES   = config_path .. '/lua/preferences.lua'
vim.env.LUACONF       = config_path .. '/lua/config.lua'
vim.env.ENV           = config_path .. '/lua/env.lua'
vim.env.PLUGINS       = config_path .. '/lua/plugins.lua'
vim.env.STARTUPTHEME  = config_path .. '/lua/startup/themes/my_theme.lua'
vim.env.VIMWIKICONFIG = config_path .. '/ftplugin/vimwiki.vim'
vim.env.QUOTES        = config_path .. '/lua/startup/themes/quotes.md'

-- spring-boot.nvim's launcher falls back to bare 'java' on PATH (Corretto 11 here)
-- when JAVA_HOME is unset, and always passes -XX:+UseZGC, which JDK 11 rejects
-- without -XX:+UnlockExperimentalVMOptions. Point JAVA_HOME at the JDK nvim-java
-- already downloads, scoped to this process only (doesn't touch shell/system env).
vim.env.JAVA_HOME = vim.fn.stdpath'data' .. '/nvim-java/packages/openjdk/25/jdk-25.0.4.1'

require'preferences'

require'mappings'

require'plugins'

require'config'

require'colors'

