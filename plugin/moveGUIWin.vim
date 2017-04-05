" Move GUI window

if !has('gui_running')
  finish
endif

" To allow a count preceding the mapped keys, '<C-U>' has to be used.
nnoremap <silent> <Left>  :<C-U>MoveGUIWin 'Left', v:count<CR>
nnoremap <silent> <Down>  :<C-U>MoveGUIWin 'Down', v:count<CR>
nnoremap <silent> <Up>    :<C-U>MoveGUIWin 'Up', v:count<CR>
nnoremap <silent> <Right> :<C-U>MoveGUIWin 'Right', v:count<CR>

" These mappings don't need the user command 'MoveGUIWin'.
" nnoremap <Left>  :<C-U>call <SID>MoveGUIWin('Left', v:count)<CR>
" nnoremap <Down>  :<C-U>call <SID>MoveGUIWin('Down', v:count)<CR>
" nnoremap <Up>    :<C-U>call <SID>MoveGUIWin('Up', v:count)<CR>
" nnoremap <Right> :<C-U>call <SID>MoveGUIWin('Right', v:count)<CR>

command! -nargs=+ MoveGUIWin call s:MoveGUIWin(<args>)

function! s:MoveGUIWin(direction, pixnr)
  if a:pixnr > 0                | let g:moveGUIWinPix = a:pixnr | endif
  if !exists('g:moveGUIWinPix') | let g:moveGUIWinPix = 1       | endif
  if g:moveGUIWinPix < 1
    let g:moveGUIWinPix = 1
  elseif g:moveGUIWinPix > 200
    let g:moveGUIWinPix = 200
  endif
  echo 'MoveGUIWin to <' . a:direction . '> by' g:moveGUIWinPix 'pixels.'
  if a:direction ==? 'Left'
    execute 'winpos' (getwinposx() - g:moveGUIWinPix) getwinposy()
  elseif a:direction ==? 'Down'
    execute 'winpos' getwinposx() (getwinposy() + g:moveGUIWinPix)
  elseif a:direction ==? 'Up'
    execute 'winpos' getwinposx() (getwinposy() - g:moveGUIWinPix)
  elseif a:direction ==? 'Right'
    execute 'winpos' (getwinposx() + g:moveGUIWinPix) getwinposy()
  endif
endfunction

