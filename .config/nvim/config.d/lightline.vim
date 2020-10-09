let g:lightline = {
  \ 'colorscheme': 'base16_default_dark',
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
