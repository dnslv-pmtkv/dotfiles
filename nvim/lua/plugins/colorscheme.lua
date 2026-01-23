return {
  -- 'olimorris/onedarkpro.nvim',
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'dark', -- dark, darker, cool, deep, warm, warmer, light

      code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
    }

    require('onedark').load()
  end,
}
