#!/bin/bash

nvim_python_config() {

  mkdir -p ~/.config/nvim/lua/plugins/

  cat <<EOF >~/.config/nvim/lua/plugins/python.lua
return {
  -- 1. Garante que as ferramentas (pyright, ruff) estejam instaladas pelo Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "pyright", "ruff-lsp", "ruff" })
    end,
  },

  -- 2. Configura os servidores de linguagem (LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Pyright para análise de tipos, autocompletar, etc.
        pyright = {},
        -- Ruff para linting, organização de imports e "code actions"
        ruff_lsp = {},
      },
    },
  },

  -- 3. Configura a formatação com Ruff
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- 4. Desativa o linting via nvim-lint para evitar duplicidade, pois ruff-lsp já faz isso
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = {}, -- Desativa o linter padrão para Python aqui
      },
    },
  },
}
EOF

  echo "Arquivo de configuração do nvim-python criado em ~/.config/nvim/lua/plugins/python.lua"
}
