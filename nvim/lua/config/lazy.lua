-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{
				vim.fn.system({	'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }),
				'WarningMsg'
			},
			{ '\nPress any key to exit...' },
		}, true, {})

		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend('~/.local/share/nvim/lazy/lazy.nvim')

-- Setup lazy.nvim
require('lazy').setup({
	spec = { import = 'plugins'	},
	checker = { enabled = true },
})

local lsp = require('lspconfig')
-- Setup LSP
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
local default_setup = function(server)
	lsp[server].setup({ capabilities = lsp_capabilities })
end

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'bashls', 'clangd', 'cssls', 'docker_compose_language_service', 'dockerls', 'emmet_ls', 'html', 'jdtls', 'jedi_language_server', 'kotlin_language_server', 'lua_ls', 'matlab_ls', 'omnisharp', 'terraformls', 'ts_ls' },	-- servers for autocompletion
	handlers = { default_setup },
})

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' }
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({}),				-- <Enter> key to confirm completion item
		['<C-Space>'] = cmp.mapping.complete(),			-- <Ctrl> + <Space> to trigger completion menu
		['<Tab>'] = cmp.mapping.select_next_item(),	-- <Tab> to select next completion item
		['<S-Tab>'] = cmp.mapping.select_prev_item(),	-- <Shift> + <Tab> to select previous completion item
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

-- Disable copilot by default
--vim.cmd("Copilot disable")

-- Setup gdscript
lsp['gdscript'].setup({
	name = 'godot',
	cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
})

-- Fix matlab's root directory
lsp.matlab_ls.setup({
	cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/matlab-language-server"), "--stdio" },
	root_dir = function(fname)
		return require('lspconfig.util').root_pattern('.git')(fname) or vim.fn.getcwd()
	end,
})

-- Fix kotlin's root directory
lsp.kotlin_language_server.setup({
  cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/kotlin-language-server") },
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern('.git')(fname) or vim.fn.getcwd()
  end,
  init_options = {
    -- Set a proper storage path as a string.
    storagePath = vim.fn.expand("~/.cache/kotlin-language-server"),
  },
})

-- Ignore 'vim' as an error in lua
lsp.lua_ls.setup({
	capabilities = lsp_capabilities,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = { library = vim.env.VIMRUNTIME }
		}
	}
})

-- Find external libraries in clangd (c++)
lsp.clangd.setup {
	capabilities = lsp_capabilities,
    cmd = { 'clangd', '--compile-commands-dir=build', '--header-insertion=never' },
    root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git')
}

-- Setup telescope layout and lsp code actions
local telescope = require('telescope')

telescope.setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			preview_cutoff = 0,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown{}
		}
	}
})

telescope.load_extension('ui-select')

-- Setup required functions
local fn = {}

-- Telescope
function fn.telescope(task)
	return require('telescope.builtin')[task]({
		no_ignore = true,
		hidden = true,
	})
end

-- Harpoon
local conf = require('telescope.config').values
function fn.harpoon(files)
	local file_paths = {}

	for _, item in ipairs(files.items) do
		table.insert(file_paths, item.value)
	end

	require('telescope.pickers').new({}, {
		prompt_title = 'Harpoon',
		finder = require('telescope.finders').new_table({ results = file_paths }),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end

return fn
