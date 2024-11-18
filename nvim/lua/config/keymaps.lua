-- Nvim
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)		-- open file explorer


-- For Plugins
local fn = require('config.lazy')


-- Telescope
-- search files
vim.keymap.set('n', '<leader><leader>', function()
	fn.telescope('find_files')
end)

-- search inside of files
vim.keymap.set('n', '<leader>f', function()
	fn.telescope('live_grep')
end)


-- Fugitive
vim.keymap.set('n', '<leader>g', vim.cmd.Git)	-- show git status


-- Harpoon
local harpoon = require('harpoon')
harpoon:setup()

-- open harpoon window
vim.keymap.set('n', '<leader>h', function()
	fn.harpoon(harpoon:list())
end, { desc = 'Open harpoon window' })

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)		-- add file
vim.keymap.set('n', '<leader>r', function() harpoon:list():remove() end)	-- remove all files
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end)	-- open 1st file
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end)	-- open 2nd file
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end)	-- open 3rd file
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end)	-- open 4th file
vim.keymap.set('n', '<leader>5', function() harpoon:list():select(5) end)	-- open 5th file
