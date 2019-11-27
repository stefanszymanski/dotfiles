" " === Use ripgrep === "
" " Use ripgrep for searching current directory for files
" " By default, ripgrep will respect rules in .gitignore
" "   --files  Print each file that would be searched (but don't search)
" "   --glob   Include or exclues files for searching that match the given glob
" "            (aka ignore .git files)
" call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" " Use ripgrep in place of "grep"
" call denite#custom#var('grep', 'command', ['rg'])

" " Custom options for ripgrep
" "   --vimgrep   Show results with every match on it's own line
" "   --heading   Show the file name above clusters of matches from each file
" "    -S         Search case insensitively if the pattern is all lowercase
" call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--heading', '-S'])

" " Recommended defaults for ripgrep via Denite docs
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])

" call denite#custom#source('grep', 'converters', ['converter/abbr_word'])

" " Set date format for buffer list
" call denite#custom#var('buffer', 'date_format', '%Y-%m-%d %H:%M:%S')


" " === Custom options === "
" "   auto_resize             - Auto resize the Denite window height automatically.
" "   prompt                  - Customize denite prompt
" "   direction               - Specify Denite window direction as directly below current pane
" "   winminheight            - Specify min height for Denite window
" "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
" "   prompt_highlight        - Specify color of prompt
" "   highlight_matched_char  - Matched characters highlight
" "   highlight_matched_range - matched range highlight
" let s:denite_options = {'default' : {
"     \ 'auto_resize': 1,
"     \ 'prompt': '❯:',
"     \ 'direction': 'rightbelow',
"     \ 'winminheight': '10',
"     \ 'highlight_mode_insert': 'Visual',
"     \ 'highlight_mode_normal': 'Visual',
"     \ 'prompt_highlight': 'Function',
"     \ 'highlight_matched_char': 'Function',
"     \ 'highlight_matched_range': 'Normal'
"     \ }}

" function! s:profile(opts) abort
"   for fname in keys(a:opts)
"     for dopt in keys(a:opts[fname])
"       call denite#custom#option(fname, dopt, a:opts[fname][dopt])
"     endfor
"   endfor
" endfunction


" " === Denite actions === "
" "   <return> - open
" "   d        - delete
" "   p        - show a preview
" "   q        - close denite
" "   i        - jump to filter buffer
" "   h        - open in horizontal split view
" "   v        - open in vertical split view
" "   t        - open in tab
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
"     nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
"     nnoremap <silent><buffer><expr> d    denite#do_map('do_action', 'delete')
"     nnoremap <silent><buffer><expr> p    denite#do_map('do_action', 'preview')
"     nnoremap <silent><buffer><expr> q    denite#do_map('quit')
"     nnoremap <silent><buffer><expr> <ESC>    denite#do_map('quit')
"     nnoremap <silent><buffer><expr> i    denite#do_map('open_filter_buffer')
"     nnoremap <silent><buffer><expr> h    denite#do_map('do_action', 'split')
"     nnoremap <silent><buffer><expr> v    denite#do_map('do_action', 'vsplit')
"     nnoremap <silent><buffer><expr> t    denite#do_map('do_action', 'tabopen')
" endfunction


" " === Denite bindings === "
" "   <leader>bp      - Browse files in working directory
" "   <leader>bb      - Browse open buffers
" "   <leader>bc      - Browse directory of current buffer
" "   <leader>/       - Search by pattern in working directory
" "   <leader>fw      - Search word under cursor in working directory
" "   <leader>fr      - Resume latest search
" nnoremap <leader>bp :<C-u>Denite file/rec -start-filter<CR>
" nnoremap <leader>; :<C-u>Denite buffer -start-filter<CR>
" nnoremap <leader>bc :<C-u>DeniteBufferDir file/rec -start-filter<CR>
" nnoremap <leader>/  :<C-u>Denite grep:.<CR>
" nnoremap <leader>fw :<C-u>DeniteCursorWord grep:.<CR>
" nnoremap <leader>fr :<C-u>Denite -resume -cursor-pos=+1<CR>
