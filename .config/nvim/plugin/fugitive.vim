" add and remove from stage
nmap <leader>gs :Git add %<cr>
nmap <leader>gu :Git reset HEAD %<cr>
nmap <leader>gU :Git reset HEAD .<cr>

" commit
nmap <leader>gC :Gcommit<cr>

" show various information
nmap <leader>gS :Gstatus<cr>
nmap <leader>gd :Gdiffsplit :0<cr>
nmap <leader>gB :Gblame<cr>
nmap <leader>gl :GV<cr>
