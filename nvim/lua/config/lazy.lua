-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--branch=stable',
		'https://github.com/folke/lazy.nvim.git', lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
	spec = { import = 'plugins'	},
	checker = { enabled = true },
})

local lsp = vim.lsp.config
-- Setup LSP
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
local default_setup = function(server)
	lsp(server, { capabilities = lsp_capabilities })
end

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'bashls', 'clangd', 'cssls', 'docker_compose_language_service', 'dockerls', 'emmet_ls', 'html', 'jdtls', 'jedi_language_server', 'kotlin_language_server', 'lua_ls', 'matlab_ls', 'omnisharp', 'rust_analyzer', 'terraformls', 'ts_ls' },	-- servers for autocompletion
	handlers = { default_setup }
})

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' }
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({}),				-- <Enter> key to confirm completion item
		['<C-Space>'] = cmp.mapping.complete(),			-- <Ctrl> + <Space> to trigger completion menu
		['<Tab>'] = cmp.mapping.select_next_item(),		-- <Tab> to select next completion item
		['<S-Tab>'] = cmp.mapping.select_prev_item(),	-- <Shift> + <Tab> to select previous completion item
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

-- Setup web-devicons
local devicons = require('nvim-web-devicons')
devicons.setup {
	variant = 'dark';
}

-- Setup gdscript
lsp('gdscript', {
	name = 'godot',
	cmd = vim.lsp.rpc.connect('127.0.0.1', 6005),
})
vim.lsp.enable({ 'gdscript' })

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
		['ui-select'] = {
			require('telescope.themes').get_dropdown{}
		}
	}
})

telescope.load_extension('ui-select')

-- Setup Java
local root_dir = require('jdtls.setup').find_root { 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

if root_dir then
	local workspace_path = vim.fn.stdpath('data') .. '/jdtls-workspace/'
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
	local workspace_dir = workspace_path .. project_name

	local status, jdtls = pcall(require, 'jdtls')
	if not status then
		return
	end
	local extendedClientCapabilities = jdtls.extendedClientCapabilities

	local config = {
		cmd = {
			'java',
			'-Declipse.application=org.eclipse.jdt.ls.core.id1',
			'-Dosgi.bundles.defaultStartLevel=4',
			'-Declipse.product=org.eclipse.jdt.ls.core.product',
			'-Dlog.protocol=true',
			'-Dlog.level=ALL',
			'-Xmx1g',
			'--add-modules=ALL-SYSTEM',
			'--add-opens',
			'java.base/java.util=ALL-UNNAMED',
			'--add-opens',
			'java.base/java.lang=ALL-UNNAMED',
			'-javaagent:' .. vim.fn.stdpath('data') .. '/mason/packages/jdtls/lombok.jar',
			'-jar',
			vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
			'-configuration',
			vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_linux',
			'-data',
			workspace_dir,
		},
		root_dir = root_dir,

		settings = {
			java = {
				signatureHelp = { enabled = true },
				extendedClientCapabilities = extendedClientCapabilities,
				maven = {
					downloadSources = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				inlayHints = {
					parameterNames = {
						enabled = 'all',
					},
				},
				format = {
					enabled = false,
				},
			},
		},

		init_options = {
			bundles = {},
		},
	}
	require('jdtls').start_or_attach(config)

	local jdtls_config = {
		bundles = {}
	}
	vim.list_extend(jdtls_config.bundles, require('spring_boot').java_extensions())
end

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
