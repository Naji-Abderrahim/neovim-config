return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Sources
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'saadparwaiz1/cmp_luasnip',

		-- Icons (optional, for prettier completion menu)
		'L3MON4D3/LuaSnip',
		'onsails/lspkind.nvim',
	},
	config = function()
		local cmp = require('cmp')
		local lspkind = require('lspkind')
		local luasnip = require("luasnip")
		cmp.setup(
			{
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					-- Navigate through the completion menu

					-- Scroll documentation window
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),

					-- Cancel completion
					['<C-e>'] = cmp.mapping.abort(),

					-- Confirm selection
					['<CR>'] = cmp.mapping.confirm(),

					-- Tab completion and snippet navigation
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),

					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),

					-- Complete common string
					['<C-Space>'] = cmp.mapping.complete(),

					-- ignore arrow keys
					['<Up>'] = cmp.mapping(function(fallback)
						fallback()
					end),
					['<Down>'] = cmp.mapping(function(fallback)
						fallback()
					end),
				}),

				-- Completion sources in priority order
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
					{ name = 'buffer', keyword_length = 3 },
				}),

				-- Formatting of the completion menu
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text',
						maxwidth = 50,
						ellipsis_char = '...',
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							path = "[Path]",
						},
					}),
				},

				-- Experimental features
				experimental = {
					ghost_text = true,  -- Shows virtual text as a preview
				},

				-- Sort settings
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						-- Prioritize completion items that start with entered text
						function(entry1, entry2)
							local _, entry1_under = entry1.completion_item.label:find "^_+"
							local _, entry2_under = entry2.completion_item.label:find "^_+"
							entry1_under = entry1_under or 0
							entry2_under = entry2_under or 0
							if entry1_under > entry2_under then
								return false
							elseif entry1_under < entry2_under then
								return true
							end
						end,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end
	}
