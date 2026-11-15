" Vim filetype detection
" Language: AGC (Apollo Guidance Computer) assembly / YUL
"
" Note: Neovim's built-in content detection classifies any file whose first
" lines begin with '#' as 'conf'.  AGC sources always start with '#' comment
" banners, so we force the filetype rather than using ':setfiletype' (which
" would not override the earlier guess).

augroup agc_ftdetect
  autocmd!
  autocmd BufNewFile,BufRead *.agc,*.yul setlocal filetype=agc
augroup END
