-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Lines
vim.o.number = true
vim.o.relativenumber = true

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Colorscheme
vim.cmd[[colorscheme tokyonight]]

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })

-- Netrw
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 3
vim.g.netrw_winsize = 75
vim.g.netrw_liststyle = 3
