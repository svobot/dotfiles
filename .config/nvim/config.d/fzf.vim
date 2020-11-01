" Open hotkeys
map <C-p> :ProjectFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>
noremap <Leader>s :Rg<CR>

let g:fzf_layout = { 'down': '~20%' }

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!{.git,.stack-work}/*" 2>/dev/null'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" https://github.com/junegunn/fzf.vim/issues/47
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

