" Change terminal background based on vim theme
function! SyncTerminalBG()
    let l:bg = synIDattr(hlID('Normal'), 'bg#')
    if empty(l:bg)
        return
    endif

    " Remove trailing characters
    let l:seq = "\033]11;" . l:bg . "\033\\"

    " Send directly to term
    call writefile([l:seq], '/dev/tty', 'b')
endfunction

" Restore term color
function! ResetTerminalBG()
    call writefile(["\033]111\033\\"], '/dev/tty', 'b')
endfunction

" Autocmd
augroup TerminalColorSync
    autocmd!
    autocmd VimEnter,ColorScheme * call SyncTerminalBG()
    autocmd VimLeave * call ResetTerminalBG()
augroup END

