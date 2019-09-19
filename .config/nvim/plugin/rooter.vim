" Rooter automatically changes the working directory

" do not change for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'    

" change on all files
let g:rooter_targets = '/,*'

" change cwd for the current window only
let g:rooter_use_lcd = 1

" if a directory matches one of these patterns it becomes the working
" directory
let g:rooter_patterns = ['.git/', '.svn/', '.config/']
