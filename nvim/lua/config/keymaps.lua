local set = vim.keymap.set
local cmd = vim.cmd
local fn = require('config.lazy')

-- Nvim
set('n', '<leader>e', cmd.Ex)	-- open netrw explorer

-- Telescope
set('n', '<leader><leader>', function() fn.telescope('find_files') end)	-- search files
set('n', '<leader>f', function() fn.telescope('live_grep') end)			-- search inside of files
set('n', '<leader>c', function() vim.lsp.buf.code_action() end)			-- show code actions
set('n', '<leader>d', function() vim.diagnostic.open_float() end)		-- show error/warning message

-- Fugitive
set('n', '<leader>g', cmd.Git)	-- show git status

-- Harpoon
local list = require('harpoon'):list()
set('n', '<leader>h', function() fn.harpoon(list) end, { desc = 'Open harpoon window' })	-- open harpoon window
set('n', '<leader>a', function() list:add() end)		-- add buffer
set('n', '<leader>r', function() list:remove() end)		-- remove buffer
set('n', '<leader>1', function() list:select(1) end)	-- open 1st buffer
set('n', '<leader>2', function() list:select(2) end)	-- open 2nd buffer
set('n', '<leader>3', function() list:select(3) end)	-- open 3rd buffer
set('n', '<leader>4', function() list:select(4) end)	-- open 4th buffer
set('n', '<leader>5', function() list:select(5) end)	-- open 5th buffer
set('n', '<leader>6', function() list:select(6) end)	-- open 6th buffer
set('n', '<leader>7', function() list:select(7) end)	-- open 7th buffer
set('n', '<leader>8', function() list:select(8) end)	-- open 8th buffer
set('n', '<leader>9', function() list:select(9) end)	-- open 9th buffer
set('n', '<leader>0', function() list:select(10) end)	-- open 10th buffer

-- Flog
set('n', '<leader>l', cmd.Flogsplit)	-- open flog window

-- Undotree
set('n', '<leader>u', function () cmd.UndotreeToggle() cmd.UndotreeFocus() end)	-- open undotree window

-- Gutter
set('n', '<leader>j', cmd.GitGutterNextHunk)	-- next hunk
set('n', '<leader>k', cmd.GitGutterPrevHunk)	-- previous hunk

-- Netrw Tabs
set('n', '<Tab>', cmd.tabnext)			-- next tab
set('n', '<S-Tab>', cmd.tabprevious) 	-- previous tab

-- Window Navigation
set('n', '<C-h>', '<C-w>h')	-- move to left window
set('n', '<C-j>', '<C-w>j')	-- move to bottom window
set('n', '<C-k>', '<C-w>k')	-- move to top window
set('n', '<C-l>', '<C-w>l')	-- move to right window
