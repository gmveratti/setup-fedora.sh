#!/bin/bash

nvim_typescript_config() {

  mkdir -p ~/.config/nvim/lua/plugins/

  cat <<EOF >~/.config/nvim/lua/plugins/typescript.lua
return {
  -- 1. Garante que as ferramentas estejam instaladas pelo Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "prettier",
        "eslint-lsp", -- Altamente recomendado para projetos TS
      })
    end,
  },

  -- 2. Configura os servidores de linguagem (LSP)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Servidor principal para TypeScript e JavaScript
        tsserver = {},
        -- Adiciona suporte para linting com ESLint diretamente no editor
        eslint = {},
      },
    },
  },

  -- 3. Configura a formatação com Prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
      },
    },
  },
}
EOF

  echo "Arquivo de configuração do nvim-typescript criado em ~/.config/nvim/lua/plugins/typescript.lua"
}
