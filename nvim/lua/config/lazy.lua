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
	ensure_installed = { 'bashls', 'clangd', 'cssls', 'emmet_ls', 'html', 'jdtls', 'jedi_language_server', 'ltex', 'lua_ls', 'omnisharp', 'ts_ls' },	-- servers for autocompletion
	handlers = { default_setup },
})

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' }
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({}),				-- <Enter> key to confirm completion item
		['<C-Space>'] = cmp.mapping.complete(),			-- <Ctrl> + <Space> to trigger completion menu
		['<A-Tab>'] = cmp.mapping.select_next_item(),	-- <Alt> + <Tab> to select next completion item
		['<A-S-Tab>'] = cmp.mapping.select_prev_item(),	-- <Alt> + <Shift> + <Tab> to select previous completion item
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
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

-- Find external libraries in clangd
lsp.clangd.setup {
	capabilities = lsp_capabilities,
    cmd = { 'clangd', '--compile-commands-dir=build', '--header-insertion=never' },
    root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git')
}

-- Null-LS for and Mypy
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.mypy,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        end
    end,
})

-- Autoformat on Save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.format()
    end,
})


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
