" add and remove from stage
nmap <leader>gs :Git add %<cr>
nmap <leader>gu :Git reset HEAD %<cr>
nmap <leader>gU :Git reset HEAD .<cr>

" basic actions
nmap <leader>gC :Gcommit<cr>
nmap <leader>gp :Gpull<cr>
nmap <leader>gP :Gpush<cr>

" show various information
nmap <leader>gS :Gstatus<cr>
nmap <leader>gd :Gdiffsplit :0<cr>
nmap <leader>gB :Gblame<cr>

" open commit browser
nmap <leader>gl :GV<cr>
" open commit browser for current file
nmap <leader>gL :GV!<cr>
" open commit browser for visual selection
vmap <leader>gl :GV<cr>
" fill location list with revisions of current file / visual selection
nmap <leader>gr :GV!<cr>
vmap <leader>gr :GV!<cr>
