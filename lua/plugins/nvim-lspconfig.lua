local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})

	local lspconfig = require("lspconfig")

	local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- lua
	lspconfig.lua_ls.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- python
	lspconfig.pyright.setup({
		--capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				anaysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- C
	lspconfig.clangd.setup({
		--capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			clangd = {},
		},
	})

	local cpplint = require("efmls-configs.linters.cpplint")
	-- local clang_format = require("efmls-configs.formatters.clang_format")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"c",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				c = { cpplint },
				python = { flake8, black },
				lua = { luacheck, stylua },
			},
		},
	})

	-- Format so Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
	},
}
