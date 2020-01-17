function! s:run_async(cmd) abort
    let job = {'message': '', 'error': 0}
    function! job.on_exit(job_id, data, event) dict
        if self.error
            echom "Deployment failed ("  . self.message . ")"
        else
            echom "Deployment succeeded (" . self.message . ")"
        endif
    endfunction
    function! job.on_stderr(job_id, data, event) dict
        if len(a:data[0]) > 1
            let self.error = 1
            let self.message = a:data[0]
        endif
    endfunction
    function! job.on_stdout(job_id, data, event) dict
        if len(a:data) > 1 && len(a:data[-2]) > 0
            let self.message = a:data[-2]
        endif
    endfunction
    call jobstart(a:cmd, job)
endfunction

function! s:create_popup(columns, lines)
	let width = a:columns
	let height = a:lines
    let opts = {
        \ 'relative': 'editor',
        \ 'row': (&lines - height) / 2,
        \ 'col': (&columns - width) / 2,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal',
        \ 'focusable': v:false
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

function! s:run_action() abort
    let target = expand('<cWORD>')
    let action = b:deploy_action
    call call(action, [target])
endfunction

function! s:setup_buffer() abort
    setlocal buftype=nofile bufhidden=wipe noswapfile
    " setlocal nomodifiable
    setlocal nowrap cursorline
    nnoremap <buffer> <silent> q :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <esc> :$wincmd w <bar> close<cr>
    nmap <buffer> <silent> <cr> :call <sid>run_action()<cr>q
endfunction


function! deploy#async_uncommited(target) abort
    call s:run_async(["deploy",  "-t", a:target, "-sun"])
endfunction

function! deploy#async_files(target, ...) abort
    echo s:run_async(["PINENTRY_USER_DATA=gtk", "deploy", "-t", a:target, join(a:000, " ")])
endfunction

function! deploy#list_targets(...) abort
    return systemlist("deploy -l 2> /dev/null | awk '/^  / {print $1}'")
endfunction


function! deploy#uncommited() abort
    let targets = deploy#list_targets()
    if empty(targets)
        echom 'Error: No targets available!'
        return
    endif
    let [width, height] = s:get_popup_size(targets)
    let [buf, win] = s:create_popup(width, height)
    call setbufline(buf, 1, targets)
    call setwinvar(win, '&winhl', 'Normal:DeploySelector')
    call setbufvar(buf, '&filetype', 'deploy_selector')
    call setbufvar(buf, '&signcolumn', 'no')
    call setbufvar(buf, 'deploy_action', 'deploy#async_uncommited')
endfunction


autocmd FileType deploy_selector call s:setup_buffer()

command! DeployTargets call deploy#list_targets()
command! -nargs=0 DeployUncommited call deploy#uncommited()
" command! -complete=customlist,deploy#list_targets -nargs=+ DeployFiles call deploy#_files(<f-args>)

nnoremap <silent> <leader>du :<c-u>DeployUncommited<cr>
