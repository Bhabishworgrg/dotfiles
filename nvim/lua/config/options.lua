-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Lines
vim.o.number = true
vim.o.relativenumber = true

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Colorscheme
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'tokyonight',
	callback = function()
		vim.api.nvim_set_hl(0, '@variable', { fg = '#f7768e' }) -- override variable color
	end,
})
vim.cmd[[colorscheme tokyonight]]

-- Transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })			-- main window
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#000000' })	-- LSP definitions
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#000000' })			-- autocomplete menu
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })		-- non-written lines

-- Netrw
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 3
vim.g.netrw_winsize = 80
vim.g.netrw_liststyle = 3
