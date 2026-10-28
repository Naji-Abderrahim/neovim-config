return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ "williamboman/mason.nvim",           opts = {} },
		{ "williamboman/mason-lspconfig.nvim", tag = 'v2.1.0' },
		{ "hrsh7th/cmp-nvim-lsp" },
	},

	config = function()
		local m_lsp = require("mason-lspconfig")
		local mason = require("mason")
		local lspconfig = require('lspconfig')

		-- vim.lsp.set_log_level("debug")

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

		-- Unique workspace per project
		-- local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

		-- vim.lsp.config("jdtls", {
		-- 	cmd = {
		-- 		"/opt/homebrew/opt/openjdk@21/bin/java", -- confirm this path
		-- 		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		-- 		"-Dosgi.bundles.defaultStartLevel=4",
		-- 		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		-- 		"-Dlog.protocol=true",
		-- 		"-Dlog.level=ALL",
		-- 		"-Xmx1g",
		-- 		"--add-modules=ALL-SYSTEM",
		-- 		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		-- 		"--add-opens", "java.base/java.lang=ALL-UNNAMED",
		-- 		"-jar",
		-- 		"/Users/um6p_mac_naji/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
		-- 		"-configuration", "/Users/um6p_mac_naji/.local/share/nvim/mason/packages/jdtls/config_mac",
		-- 		"-data", workspace_dir,
		-- 	}
		-- })

		mason.setup()
		m_lsp.setup()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local hover = require("hover").hover
				local bufnr = args.buf
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, opts)
				vim.keymap.set("n", "<leader>q", hover, {})
				vim.keymap.set("n", "<leader>cw", function() vim.lsp.buf.workspace_symbol() end, opts)
				vim.keymap.set("n", "<leader>cf", hover, {}) -- TO-DO: this is not actually giving the right output (but it is a good fix for now)
				vim.keymap.set("n", "<leader>cn", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "<leader>cp", function() vim.diagnostic.goto_prev() end, opts)
				vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
				-- vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
				vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
				vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.signature_help() end, opts)
			end,
		})
	end
}
