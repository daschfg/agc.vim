" Vim ftplugin file
" Language: AGC (Apollo Guidance Computer) assembly / YUL

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" VirtualAGC convention: hard tabs every 8 columns.
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=0
setlocal noexpandtab

" '#' starts a comment.
setlocal commentstring=#\ %s

" Do not auto-wrap the long transcribed comment lines.
setlocal formatoptions-=t

let b:undo_ftplugin = 'setlocal tabstop< shiftwidth< softtabstop< expandtab<'
      \ . ' commentstring< formatoptions<'
