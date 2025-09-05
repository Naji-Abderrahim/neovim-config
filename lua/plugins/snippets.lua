return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Optional: provides a collection of pre-made snippets
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local fmt = require("luasnip.extras.fmt").fmt
      local rep = require("luasnip.extras").rep

      -- Load pre-made snippets (if you installed friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Custom snippets for Java
      ls.add_snippets("java", {
        -- Java class snippet
        s("class", fmt([[
        public class {} {{
            {}
        }}
        ]], {
          i(1, "ClassName"),
          i(2, "// Class content"),
        })),

        -- Java main method
        s("psvm", fmt([[
        public static void main(String[] args) {{
            {}
        }}
        ]], {
          i(1, "// Code here"),
        })),
		-- define a function
		s("function", fmt([[
		public {} {} ({}) {{
			{}
		}}
		]], {
			i(1, "retrun_type"),
			i(2, "name"),
			i(3, "args"),
			i(4, "body"),
		})),

		-- Java class that extends another class
		s("jext", fmt([[
		public class {} extends {} {{
			{}
		}}
		]], {
			i(1, "public"),
			i(2, "name"),
			i(3, "body"),
		})),

		-- Java class that implements an interface
		s("jimp", fmt([[
		public class {} implements {} {{
			{}
		}}
		]], {
			i(1, "public"),
			i(2, "name"),
			i(3, "body"),
		})),

		-- Try-catch block
		s("try", fmt([[
		try {{
			{}
		}} catch ({} {}) {{
			{}
		}}
		]], {
			i(1, "// try code"),
			i(2, "Exception"),
			i(3, "e"),
			i(4, "// catch code"),
		})),

		-- Java constructor
		s("ctor", fmt([[
		public {}({}) {{
			{}
		}}
		]], {
			i(1, "ClassName"),
			i(2, "parameters"),
			i(3, "// constructor body"),
		})),

		-- If statement
		s("if", fmt([[
		if ({}) {{
			{}
		}}
		]], {
			i(1, "condition"),
			i(2, "// code"),
		})),

		-- If-else statement
		s("ifelse", fmt([[
		if ({}) {{
			{}
		}} else {{
			{}
		}}
		]], {
			i(1, "condition"),
			i(2, "// if code"),
			i(3, "// else code"),
		})),

		-- Switch statement
		s("switch", fmt([[
		switch ({}) {{
			case {}:
			{}
			break;
			default:
			{}
			break;
		}}
		]], {
			i(1, "expression"),
			i(2, "value"),
			i(3, "// case code"),
			i(4, "// default code"),
		})),

		-- While loop
		s("while", fmt([[
		while ({}) {{
			{}
		}}
		]], {
			i(1, "condition"),
			i(2, "// code"),
		})),

		-- Do-while loop
		s("dowhile", fmt([[
		do {{
			{}
		}} while ({});
		]], {
			i(1, "// code"),
			i(2, "condition"),
		})),

		-- Enhanced for loop
		s("fore", fmt([[
		for ({} {} : {}) {{
			{}
		}}
		]], {
			i(1, "Type"),
			i(2, "item"),
			i(3, "collection"),
			i(4, "// code"),
		})),
	})

	-- Define snippets for other languages
	-- Example for Lua
	ls.add_snippets("lua", {
		s("req", fmt([[local {} = require("{}")]], {
			f(function(args)
				local parts = vim.split(args[1][1], ".", true)
				return parts[#parts] or ""
			end, {1}),
			i(1, "module")
		})),
	})

	-- Set up keybindings for navigating snippets
	vim.keymap.set({"i", "s"}, "<C-k>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end)

	vim.keymap.set({"i", "s"}, "<C-j>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end)

	vim.keymap.set({"i", "s"}, "<C-l>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)

	-- Optional: Load custom snippet files
	-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
end,
  }
}
