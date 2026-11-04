return {
  'saghen/blink.cmp',
  version = '1.*', -- release tags ship a prebuilt fuzzy-matcher binary
  event = { 'InsertEnter' },
  dependencies = { 'rafamadriz/friendly-snippets' },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      -- Only confirms an item you explicitly selected (nothing is preselected)
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        border = 'rounded',
        scrolloff = 3,
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'rounded' },
      },
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    -- Set to true for completion in the : command line
    cmdline = { enabled = false },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
