#!/bin/bash

nvim_go_config() {

  mkdir -p ~/.config/nvim/lua/plugins/

  cat <<EOF >~/.config/nvim/lua/plugins/go.lua
return {
  "ray-x/go.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("go").setup({
      -- Descomente para usar goimports em vez de gofmt ao salvar
      -- gofmt = "goimports",
    })
  end,
  -- Carrega o plugin para arquivos Go ou ao entrar na linha de comando
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  -- Comando para instalar/atualizar as ferramentas do Go (gopls, delve, etc.)
  build = ':lua require("go.install").update_all_sync()',
}
EOF

  echo "Arquivo de configuração do nvim-go criado em ~/.config/nvim/lua/plugins/go.lua"
}
