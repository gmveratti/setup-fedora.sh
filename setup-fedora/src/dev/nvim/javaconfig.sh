#!/bin/bash

nvim_java_config() {
  mkdir -p ~/.config/nvim/lua/plugins/

  cat <<EOF >~/.config/nvim/lua/plugins/java.lua

return {
  -- O plugin principal
  'nvim-java/nvim-java',

  -- (OPCIONAL, MAS RECOMENDADO PARA SPRING)
  -- Este é o nome CORRETO do plugin helper
  'elmcgill/springboot-nvim', --- CORRIGIDO

  -- Dependências
  dependencies = {
    'nvim-java/lua-async-await',
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-jdtls',
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
  },

  config = function()
    -- 1. CONFIGURAÇÃO PRINCIPAL DO NVIM-JAVA
    require('java').setup({
      -- Esta é a linha mais importante para o Spring
      spring_boot_support = true,
    })

    -- 2. (OPCIONAL) CONFIGURAÇÃO DO HELPER DO SPRING BOOT
    -- Note que o nome é 'springboot-nvim' e não 'spring-boot'
    require('springboot-nvim').setup({}) --- CORRIGIDO

    -- 3. CONFIGURAÇÃO DA UI DO DEBUGGER
    local dapui = require('dapui')
    dapui.setup()

    -- 4. ATALHOS DE TECLADO PARA DEBUG (sem alteração)
    local map = vim.keymap.set
    local opts = { desc = 'Debug (DAP)' }

    map('n', '<leader>db', require('dap').toggle_breakpoint, opts)
    map('n', '<leader>dc', require('dap').continue, opts)
    map('n', '<leader>do', require('dap').step_over, opts)
    map('n', '<leader>di', require('dap').step_into, opts)
    map('n', '<leader>ds', require('dap').step_out, opts)
    map('n', '<leader>du', dapui.toggle, opts)
    map('n', '<leader>dr', require('dap').repl.toggle, opts)

    -- Abre/Fecha a UI do DAP automaticamente (sem alteração)
    require('dap').listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    require('dap').listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    require('dap').listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
EOF

  echo "Arquivo de configuração do nvim-java criado em ~/.config/nvim/lua/plugins/java.lua"
}
