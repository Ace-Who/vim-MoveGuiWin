" Move GUI window

" Set the 'cpoptions' option to its Vim default value and restore it later.
" This is to enable line-continuation within this script.
" Refer to :help use-cpo-save.
let s:save_cpoptions = &cpoptions
set cpoptions&vim

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

function! s:MoveGUIWin(direction, px)
  " 'v:count' defaults to zero when no count is used.
  if a:px > 0                   | let g:MoveGUIWin_px = a:px | endif
  if !exists('g:MoveGUIWin_px') | let g:MoveGUIWin_px = 8    | endif
  " Use a local variable with short name for conciseness.
  let l:px = g:MoveGUIWin_px
  if     l:px < 1   | let l:px = 1
  elseif l:px > 200 | let l:px = 200 | endif
  if a:direction ==? 'Left'
    execute 'winpos' (getwinposx() - l:px) getwinposy()
  elseif a:direction ==? 'Down'
    execute 'winpos' getwinposx() (getwinposy() + l:px)
  elseif a:direction ==? 'Up'
    execute 'winpos' getwinposx() (getwinposy() - l:px)
  elseif a:direction ==? 'Right'
    execute 'winpos' (getwinposx() + l:px) getwinposy()
  endif
  echo 'MoveGUIWin to <' . a:direction . '> by' l:px . 'px.'
  \ 'now: (' . getwinposx() . ',' getwinposy() . ')'
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
