-- Map leader keys
vim.g.mapleader = ' '

-- Disable copilot
vim.g.copilot_enabled = false

-- Load configuration files
require('config.lazy')
require('config.options')
require('config.keymaps')
