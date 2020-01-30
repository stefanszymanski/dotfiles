let s:deploys = []
let s:history_size = 50

" Run a command async and notify about success or failure
function! s:run_async(cmd) abort
    let cmd = a:cmd
    let job = {}
    let job.deploy = {
        \ 'cmd': cmd, 
        \ 'message': '', 
        \ 'running': v:true, 
        \ 'error': v:false, 
        \ 'start': strftime('%H:%M:%S'),
        \ 'rstart': reltime(), 
        \ 'rend': 0
    \ }
    function! job.on_exit(id, data, event) dict
        let self.deploy.running = v:false
        let self.deploy.rend = reltime()
        let message = self.deploy.error ? "Deployment failed (%s)" : "Deployment succeded (%s)"
        echom printf(message, self.deploy.message)
    endfunction
    function! job.on_stderr(id, data, event) dict
        if len(a:data[0]) > 1
            let self.deploy.error = v:true
            let self.deploy.message = a:data[0]
        endif
    endfunction
    function! job.on_stdout(id, data, event) dict
        if len(a:data) > 1 && len(a:data[-2]) > 0
            let self.deploy.message = a:data[-2]
        endif
    endfunction
    let job_id = jobstart(cmd, job)
    call add(s:deploys, job.deploy)
    " log rotation
    if len(s:deploys) > s:history_size
        let n = s:history_size
        let s:deploys = s:deploys[-s:history_size:-1]
    endif
endfunction

" TODO update when a deploy changes while the window is opened
" Show the deploy history in a floating window
function! deploy#list_processes() abort
    if len(s:deploys) == 0
        echo 'No deploys yet'
        return
    endif
    let height = 25
    let width = float2nr(&columns * 0.8)
    let [buf, _] = s:create_popup(width, height)
    let lines = []
    for deploy in reverse(s:deploys)
        let line = []
        let state = deploy.running ? '[P]' : (deploy.error ? '[F]' : '[S]')
        let start = deploy.start
        let duration = deploy.running ? '' : printf("(%.2fs)", reltimefloat(reltime(deploy.rstart, deploy.rend)))
        let cmd = join(deploy.cmd)
        let msg = deploy.message
        let line = printf("%s %s %-8s %s [%s]", state, start, duration, cmd, msg)
        call add(lines, line)
    endfor
    call setbufline(buf, 1, lines)
    call setbufvar(buf, '&filetype', 'deploy_processes')
endfunction

" Create a floating window
function! s:create_popup(columns, lines)
	let width = a:columns
	let height = a:lines
    let row = (&lines - height) / 2
    let col = (&columns - width) / 2
    let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal',
        \ 'focusable': v:true
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
    call s:run_async(['deploy', '-t', target] + cmd)
endfunction

" Setup the selector buffer
function! s:setup_buffer() abort
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal nomodifiable nowrap cursorline
    nnoremap <buffer> <silent> q :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <esc> :$wincmd w <bar> close<cr>
    nnoremap <buffer> <silent> <cr> :call <sid>run_cmd()<cr> :$wincmd w <bar> close<cr>
    augroup DeployTargetSelector
        au BufLeave <buffer> :q
    augroup END
endfunction

function! s:setup_processes() abort
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal nomodifiable wrap cursorline
    setlocal showbreak=\ \ \ \ 
    nnoremap <buffer> <silent> q :q<cr>
    nnoremap <buffer> <silent> <esc> :q<cr>
    augroup DeployProcessList
        au BufLeave <buffer> :q
    augroup END

    syn clear
    syn match DeployPending /^\[P\]/
    syn match DeployFailed /^\[F\]/
    syn match DeploySucceded /^\[S\]/
    " syn match DeployError /\[[^\]]+\]$/
    " syn match DeployTime /v[0-9]{2}:[0-9]{2}:[0-9]{2}( \([0-9.]+s\))?/

    hi def link DeployPending GruvboxAqua
    hi def link DeployFailed GruvboxRed
    hi def link DeploySucceded GruvboxGreen
    " hi def link DeployError GruvboxRed
    " hi def link DeployTime GruvboxRed
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
    call setbufvar(buf, '&filetype', 'deploy_selector')
    call setbufvar(buf, '&signcolumn', 'no')
    call setbufvar(buf, 'deploy_cmd', a:cmd)
endfunction

" Either execute a command for the default target or display the target
" selection
function! deploy#execute(cmd, use_default_target) abort
    if a:use_default_target
        call s:run_async(['deploy', '-d'] + a:cmd)
    else
        call deploy#select_target(a:cmd)
    endif
endfunction

function! deploy#cancel_all() abort
    for job_id in keys(g:deploy_running_cmds)
        call jobstop(job_id)
    endfor
endfunction

" function! deploy#async_files(target, ...) abort
"     call s:run_async(["PINENTRY_USER_DATA=gtk", "deploy", "-t", a:target, join(a:000, " ")])
" endfunction

function! deploy#list_targets(...) abort
    return systemlist("deploy -l 2> /dev/null | tail -n +4")
endfunction


autocmd FileType deploy_selector call s:setup_buffer()
autocmd FileType deploy_processes call s:setup_processes()

command! DeployTargets call deploy#list_targets()
command! -bang -nargs=0 DeployUncommited call deploy#execute(['-sun'], <bang>0)
command! -bang -nargs=0 DeployCurrent call deploy#execute([expand("%:p")], <bang>0)
command! -bang -nargs=0 DeployAll call deploy#execute(['-a'], <bang>0)
command! -nargs=0 DeployHistory call deploy#list_processes()

nnoremap <silent> <leader>dh :<c-u>DeployHistory<cr>

" select target and deploy
nnoremap <silent> <leader>du :<c-u>DeployUncommited<cr>
nnoremap <silent> <leader>dc :<c-u>DeployCurrent<cr>
nnoremap <silent> <leader>da :<c-u>DeployAll<cr>

" deploy to default target
nnoremap <silent> <leader>dU :<c-u>DeployUncommited!<cr>
nnoremap <silent> <leader>dC :<c-u>DeployCurrent!<cr>
nnoremap <silent> <leader>dA :<c-u>DeployAll!<cr>

" TODO nerdtree integration
