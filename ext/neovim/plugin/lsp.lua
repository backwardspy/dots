local lsp = require("lspconfig")

local function maybe_setup_codelens(client, bufnr)
  if not client.server_capabilities.codeLensProvider then return end

  -- as per :help vim.lsp.codelens.refresh
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorHold" }, {
    group = vim.api.nvim_create_augroup("LSPCodeLens", {}),
    callback = vim.lsp.codelens.refresh,
    buffer = bufnr,
  })
end

local on_attach = function(client, bufnr)
  maybe_setup_codelens(client, bufnr)
end

local setup = function(server, opts)
  opts = opts or {}
  opts.on_attach = on_attach
  server.setup(opts)
end

-- python
require("py_lsp").setup()
setup(lsp.ruff_lsp)

-- rust
local codelldb_path = vim.fn.stdpath("data") .. "/codelldb"
require("rust-tools").setup({
  server = { on_attach = on_attach },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb_path .. "/adapter/codelldb",
      codelldb_path .. "/lldb/lib/liblldb.so"
    )
  }
})

-- lua
setup(lsp.lua_ls, {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      }
    },
  },
})

-- nix
setup(lsp.nil_ls, { settings = { ["nil"] = { formatting = { command = { "alejandra" } } } } })

-- js/ts
setup(lsp.tsserver)
setup(lsp.eslint)

-- lsp symbol icons
require("lspkind").init({
  symbol_map = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",

    Array = " ",
    Boolean = " ",
    Copilot = " ",
    Key = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Package = " ",
    String = " ",
  }
})

-- multiline diagnostics
require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = false })

-- progress listener
require("lsp-progress").setup({ decay = 3000 })
