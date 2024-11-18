return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',

	config = function ()
		local configs = require('nvim-treesitter.configs')
		configs.setup({
			ensure_installed = { 'bash', 'c', 'cpp', 'c_sharp', 'css', 'diff', 'html', 'java', 'javascript', 'lua', 'python', 'regex' },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
		})
	end
}
