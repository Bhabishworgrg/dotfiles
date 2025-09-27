-- Copilot
vim.g.copilot_enabled = false

-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Colors
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'tokyonight',
	callback = function()
		local set_hl = vim.api.nvim_set_hl
		set_hl(0, '@variable', { fg = '#f7768e' }) 		-- variable color
		set_hl(0, 'Normal', { bg = 'none' })			-- main window
		set_hl(0, 'NormalFloat', { bg = '#000000' })	-- LSP definitions
		set_hl(0, 'Pmenu', { bg = '#000000' })			-- autocomplete menu
		set_hl(0, 'EndOfBuffer', { bg = 'none' })		-- non-written lines
	end,
})
vim.cmd.colorscheme('tokyonight')

-- Netrw
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 3
vim.g.netrw_winsize = 80
vim.g.netrw_liststyle = 3
