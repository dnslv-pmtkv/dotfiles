local function set_highlights()
  for _, group in ipairs {
    'IlluminatedWordText',
    'IlluminatedWordRead',
    'IlluminatedWordWrite',
  } do
    vim.api.nvim_set_hl(0, group, { link = 'Visual' })
  end
end

return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    set_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('UserIlluminate', { clear = true }),
      callback = set_highlights,
    })
  end,
}
