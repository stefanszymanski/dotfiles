" TODO gettings the latest message or error feels like a hack. isn't there a
"      better way?
" Run a command async and notify about success or failure
function! s:run_async(cmd) abort
    let cmd = ['deploy'] + a:cmd
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
    call jobstart(cmd, job)
endfunction

" Create a floating window
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

" Calculate the optimal window size for the given lines
function! s:get_popup_size(lines) abort
    let width = 0
    for target in a:lines
        if len(target) > width
            let width = len(target)
        endif
    endfor
    return [width, len(a:lines)]
endfunction

" Run the command of the selector for the selected target
function! s:run_cmd() abort
    let target = expand('<cWORD>')
    let cmd = b:deploy_cmd
    call s:run_async(['-t', target] + cmd)
endfunction

" Setup the selector buffer
function! s:setup_buffer() abort
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal nomodifiable
    setlocal nowrap cursorline
    nnoremap <buffer> <silent> q :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <esc> :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <cr> :call <sid>run_cmd()<cr> :$wincmd w <bar> close<cr>
endfunction

" Display a popup for target selection
function! deploy#select_target(cmd) abort
    let targets = deploy#list_targets()
    if empty(targets)
        echom 'Error: No targets available!'
        return
    endif
    let [width, height] = s:get_popup_size(targets)
    let [buf, win] = s:create_popup(width + 2, height)
    call setbufline(buf, 1, targets)
    call setwinvar(win, '&winhl', 'Normal:DeploySelector')
    call setbufvar(buf, '&filetype', 'deploy_selector')
    call setbufvar(buf, '&signcolumn', 'no')
    call setbufvar(buf, 'deploy_cmd', a:cmd)
endfunction

" Either execute a command for the default target or display the target
" selection
function! deploy#execute(cmd, use_default_target) abort
    if a:use_default_target
        call s:run_async(['-d'] + a:cmd)
    else
        call deploy#select_target(a:cmd)
    endif
endfunction

" function! deploy#async_files(target, ...) abort
"     call s:run_async(["PINENTRY_USER_DATA=gtk", "deploy", "-t", a:target, join(a:000, " ")])
" endfunction

function! deploy#list_targets(...) abort
    return systemlist("deploy -l 2> /dev/null | tail -n +4")
endfunction


autocmd FileType deploy_selector call s:setup_buffer()

command! DeployTargets call deploy#list_targets()
command! -bang -nargs=0 DeployUncommited call deploy#execute(['-sun'], <bang>0)
command! -bang -nargs=0 DeployCurrent call deploy#execute([expand("%:p")], <bang>0)
command! -bang -nargs=0 DeployAll call deploy#execute(['-a'], <bang>0)

" select target and deploy
nnoremap <silent> <leader>du :<c-u>DeployUncommited<cr>
nnoremap <silent> <leader>dc :<c-u>DeployCurrent<cr>
nnoremap <silent> <leader>da :<c-u>DeployAll<cr>

" deploy to default target
nnoremap <silent> <leader>dU :<c-u>DeployUncommited!<cr>
nnoremap <silent> <leader>dC :<c-u>DeployCurrent!<cr>
nnoremap <silent> <leader>dA :<c-u>DeployAll!<cr>
