augroup language_detection
  au!

  " Normalize ansible-vim's jinja2 alias; keep the existing YAML exception.
  au BufNewFile,BufRead *.j2,*.jinja2,*.jinja set filetype=jinja
  au BufNewFile,BufRead *.yml.j2 set filetype=yaml
  au BufNewFile,BufRead *.arb	   set ft=ruby
  au BufNewFile,BufRead *.lmx    set filetype=haml

  " for alternative Gemfiles
  au BufNewFile,BufRead Gemfile_* let &filetype = 'ruby'
augroup END

augroup languages_settings
  au!

  " pretty colymn hi for yaml modes
  au FileType yaml setlocal cursorcolumn
  au FileType eruby.yaml setlocal cursorcolumn

  " js with 2 tabs
  au FileType javascript setl sw=2 sw=2 sts=2
augroup END

augroup reload_buffer_on_change
  au!
  au BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
augroup END

function! TrimTrailingWhitespace() abort
  if &buftype !=# '' || !&modifiable || &readonly || &binary || expand('%') ==# ''
    return
  endif
  " Preserve prose, templates and fixtures; allow a buffer-local opt-out.
  if !get(b:, 'trim_trailing_whitespace', 1)
    return
  endif
  if index(['ruby', 'lua', 'go', 'rust', 'python', 'javascript', 'javascriptreact',
        \ 'typescript', 'typescriptreact', 'vim', 'sh', 'zsh', 'css', 'scss', 'json', 'toml'], &filetype) < 0
    return
  endif
  if expand('%:p') =~# '\v/(fixtures?|testdata|snapshots?|__snapshots__)/'
    return
  endif
  let l:view = winsaveview()
  try
    keepjumps keeppatterns %s/\s\+$//e
  finally
    call winrestview(l:view)
  endtry
endfunction

augroup auto_remove_trailing_whitespaces
  au!
  au BufWritePre * call TrimTrailingWhitespace()
augroup END

augroup terminal_settings
  autocmd!

  autocmd BufWinEnter term://* startinsert
  " autocmd WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert

  " go back to insert mode when entering the terminal window
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

augroup anyjump_searcher
  au!
  au BufNewFile,BufRead * let b:preferred_searcher = 'rg'
augroup END
