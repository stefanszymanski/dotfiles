function! deploy#_uncommited(target) abort
    echo system("deploy -t " . a:target . " -sun")
endfunction

function! deploy#_files(target, ...) abort
    echo system("PINENTRY_USER_DATA=gtk deploy -t " . a:target . " " . join(a:000, " "))
endfunction

function! deploy#list_targets(...) abort
    return systemlist("deploy -l | awk '/^  / {print $1}'")
endfunction

function! s:popup(columns, lines)
	let width = a:columns
	let height = a:lines
    let opts = {
        \ 'relative': 'editor',
        \ 'row': (&lines - height) / 2,
        \ 'col': (&columns - width) / 2,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
    \}
    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)
    return [buf, win]
endfunction

function! s:get_popup_size(lines) abort
    let width = 0
    for target in a:lines
        if len(target) > width
            let width = len(target)
        endif
    endfor
    return [width, len(a:lines)]
endfunction

function! deploy#uncommited() abort
    let targets = deploy#list_targets()
    let [width, height] = s:get_popup_size(targets)
    let [buf, win] = s:popup(width, height)
    call nvim_buf_set_lines(buf, 0, -1, v:true, targets)
    call nvim_buf_set_option(buf, 'filetype', 'DeploySelector')
endfunction

function! s:setup_popup() abort
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal nomodifiable
    setlocal nowrap cursorline
    nnoremap <buffer> <silent> q :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <esc> :$wincmd w <bar> close<cr>
endfunction

autocmd FileType DeploySelector call s:setup_popup()

command! DeployTargets call deploy#list_targets()
command! -nargs=0 DeployUncommited call deploy#uncommited()
" command! -complete=customlist,deploy#list_targets -nargs=+ DeployFiles call deploy#_files(<f-args>)

nnoremap <silent> <leader>du :<c-u>DeployUncommited<cr>
