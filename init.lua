-- Global variables
vim.cmd([[
let $MYVIMRC='~\AppData\Local\nvim\init.lua'
let $INIT='~\AppData\Local\nvim\init.lua'
let $MAPPINGS='~\AppData\Local\nvim\lua\mappings.lua'
let $LUACONF='~\AppData\Local\nvim\lua\config.lua'
let $ENV='~\AppData\Local\nvim\lua\env.lua'
let $PLUGINS='~\AppData\Local\nvim\lua\plugins.lua'
let $STARTUPTHEME='~\AppData\Local\nvim\lua\startup\themes\my_theme.lua'
]])

require'preferences'

require'mappings'

require'plugins'

require'config'

require'colors'
