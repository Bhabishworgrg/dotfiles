-- Set <space> as leader key
vim.g.mapleader = ' '

-- Load configuration files
require('config.lazy')
require('config.options')
require('config.keymaps')
