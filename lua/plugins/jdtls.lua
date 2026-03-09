return {
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
      local jdtls_group = vim.api.nvim_create_augroup("JDTLS", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        group = jdtls_group,
        callback = function()
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
          local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name

          -- Create workspace directory if it doesn't exist
          if vim.fn.isdirectory(workspace_dir) == 0 then
            vim.fn.mkdir(workspace_dir, "p")
          end

          -- Find the JDTLS command with fallbacks
          local jdtls_cmd = 'jdtls'  -- Default to system PATH
 
          -- Try to find JDTLS in Mason first
          local mason_registry = require('mason-registry')
          if mason_registry.is_installed and mason_registry.is_installed('jdtls') then
            local package = mason_registry.get_package('jdtls')
            if package then
              local install_path = package:get_install_path()
              if install_path then
                jdtls_cmd = install_path .. '/bin/jdtls'
              end
            end
          end
 
          -- Check common locations as fallbacks
          local potential_paths = {
            vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/bin/jdtls'),
            vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'),
            '/usr/local/bin/jdtls',
            '/usr/bin/jdtls',
          }
 
          for _, path in ipairs(potential_paths) do
            if vim.fn.executable(path) == 1 and jdtls_cmd == 'jdtls' then
              jdtls_cmd = path
              break
            end
          end


          -- Build the proper config
          local config = {
            cmd = {
              jdtls_cmd,
              '--jvm-arg=-Xmx1G',
              '--jvm-arg=-XX:+UseG1GC',
              '--jvm-arg=-XX:MaxGCPauseMillis=100',
              '--jvm-arg=-Xms100m',
              '-data', workspace_dir,
            },
            -- Find project root
            root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-17",
                      path = "/usr/lib/jvm/java-17-openjdk/",
                    },
                    {
                      name = "JavaSE-21",
                      path = "/usr/lib/jvm/java-21-openjdk/",
                      default = true,
                    },
                  }
                },
                signatureHelp = { enabled = true },
              }
            },
            init_options = {
              bundles = {}
            },
            on_attach = function(client, bufnr)
              -- Same keymaps as before
			  local hover = require("hover").hover
              local opts = { buffer = bufnr, remap = false }
              vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
              vim.keymap.set("n", "<leader>q", hover(), {})
              vim.keymap.set("n", "<leader>cw", function() vim.lsp.buf.workspace_symbol() end, opts)
              vim.keymap.set("n", "<leader>cf", hover, {})
              vim.keymap.set("n", "<leader>cn", function() vim.diagnostic.goto_next() end, opts)
              vim.keymap.set("n", "<leader>cp", function() vim.diagnostic.goto_prev() end, opts)
              vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
              vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
              vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
              vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
            end,
          }

          -- Start JDTLS with a small delay
          vim.defer_fn(function()
            require('jdtls').start_or_attach(config)
          end, 100)
        end,
      })
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    }
  }
}
