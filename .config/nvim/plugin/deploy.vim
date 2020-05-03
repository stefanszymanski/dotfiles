" === Clap provider: target select === "
" Lets choose from a list of available targets and deploy to the selection.
" 
" Depends on plugins:
"   - https://github.com/liuchengxu/vim-clap
"   - https://github.com/tpope/vim-dispatch

let s:deploy = {}

function! s:deploy.source() abort
    let targets = systemlist('deploy -Lv')
    let g:clap.context.args = g:clap.provider.args
    if v:shell_error
        call clap#helper#echo_error('Error on calling `deploy -Lv`, maybe deployment is not configured.')
        return []
    else
        return targets
    endif
endfunction

function! s:deploy.sink(selected) abort
    let target = split(a:selected)[0]
    let silent = get(g:clap.context, 'silent', v:false)
    let args = get(g:clap.context, 'args', [])
    call deploy#to_target(target, args, silent)
endfunction

let g:clap_provider_deploy = s:deploy


" === Clap provider: file select === "
" Displays two Clap dialogs consecutively:
"   1. `files` for choosing one or more files
"   2. `deploy` for choosing a deploy target

let s:deploy_files = {}

function! s:deploy_files_source() abort
    " list files and directories using the default provider `files`
    let g:clap.context.finder = 'fd --type d --type f'
    return g:clap#provider#files#.source()
endfunction

function! s:deploy_files_sink(selected) abort
    let silent = get(g:clap.context, 'silent', v:false)
    call deploy#interactive([a:selected], silent)
endfunction

function! s:deploy_files_sink_star(selected) abort
    let silent = get(g:clap.context, 'silent', v:false)
    call deploy#interactive(a:selected, silent)
endfunction

let s:deploy_files = {}
let s:deploy_files.source = function('s:deploy_files_source')
let s:deploy_files.sink = function('s:deploy_files_sink')
let s:deploy_files['sink*'] = function('s:deploy_files_sink_star')
let g:clap_provider_deploy_files = s:deploy_files


" === Functions === "

function! deploy#execute(args, silent) abort
    let cmd = join(['deploy'] + a:args)
    if a:silent
        execute join(['Dispatch!', cmd])
    else
        execute join(['Dispatch', cmd])
    endif
endfunction

function! deploy#interactive(args, silent) abort
    let cmd = ['Clap', 'deploy']
    if a:silent
        call add(cmd, '+silent')
    endif
    execute join(cmd + a:args)
endfunction

function! deploy#to_target(target, args, silent) abort
    let args = ['-t', a:target] + a:args
    call deploy#execute(args, a:silent)
endfunction

function! deploy#to_default(args, silent) abort
    let args = ['-d'] + a:args
    call deploy#execute(args, a:silent)
endfunction

function! deploy#targets(...) abort
    let targets = systemlist('deploy -L')
    if v:shell_error
        echoerr 'Error on calling `deploy -L`, maybe deployment is not configured.'
        return []
    else
        return targets
    endif
endfunction


" === Commands === "

" specify target as command argument
command! -bang -nargs=1 -complete=customlist,deploy#targets DeployChanged call deploy#to_target(<f-args>, ['-sun'], <bang>0)
command! -bang -nargs=1 -complete=customlist,deploy#targets DeployCurrent call deploy#to_target(<f-args>, [expand('%:p')], <bang>0)
command! -bang -nargs=1 -complete=customlist,deploy#targets DeployAll     call deploy#to_target(<f-args>, ['-a'], <bang>0)

" deploy to default target
command! -bang -nargs=0 DeployChangedDefault call deploy#to_default(['-sun'], <bang>0)
command! -bang -nargs=0 DeployCurrentDefault call deploy#to_default([expand('%:p')], <bang>0)
command! -bang -nargs=0 DeployAllDefault     call deploy#to_default(['-a'], <bang>0)

" select target with Clap
command! -bang -nargs=0 DeployChangedInteractive    call deploy#interactive(['-sun'], <bang>0)
command! -bang -nargs=0 DeployCurrentInteractive    call deploy#interactive([expand('%:p')], <bang>0)
command! -bang -nargs=0 DeployAllInteractive        call deploy#interactive(['-a'], <bang>0)


" === Mappings === "

" with target selection, dispatch in background
nnoremap <silent> <leader>dt :<c-u>DeployCurrentInteractive!<cr>
nnoremap <silent> <leader>da :<c-u>DeployAllInteractive!<cr>
nnoremap <silent> <leader>dc :<c-u>DeployChangedInteractive!<cr>
 
" with target selection, dispatch in foreground
nnoremap <silent> <leader>dT :<c-u>DeployCurrentInteractive<cr>
nnoremap <silent> <leader>dA :<c-u>DeployAllInteractive<cr>
nnoremap <silent> <leader>dC :<c-u>DeployChangedInteractive<cr>

" with file and target selection
nnoremap <silent> <leader>df  :<C-u>Clap deploy_files +silent<CR>
nnoremap <silent> <leader>dF  :<C-u>Clap deploy_files<CR>

" to default target, dispacth in background
nnoremap <silent> <leader>Dt :<c-u>DeployCurrentDefault!<cr>
nnoremap <silent> <leader>Da :<c-u>DeployAllDefault!<cr>
nnoremap <silent> <leader>Dc :<c-u>DeployChangedDefault!<cr>

" to default target, dispacth in foreground
nnoremap <silent> <leader>DT :<c-u>DeployCurrentDefault<cr>
nnoremap <silent> <leader>DA :<c-u>DeployAllDefault<cr>
nnoremap <silent> <leader>DC :<c-u>DeployChangedDefault<cr>
