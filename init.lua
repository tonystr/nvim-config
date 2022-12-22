-- Global variables
vim.cmd([[
let $MYVIMRC='~\AppData\Local\nvim\init.lua'
let $INIT='~\AppData\Local\nvim\init.lua'
let $LUACONF='~\AppData\Local\nvim\lua\config.lua'
let $ENV='~\AppData\Local\nvim\lua\env.lua'
let $PLUGINS='~\AppData\Local\nvim\lua\plugins.lua'
let $STARTUPTHEME='~\AppData\Local\nvim\lua\startup\themes\my_theme.lua'
]])

require'plugins'

require'config'

require'preferences'

require'colors'

require'mappings'
