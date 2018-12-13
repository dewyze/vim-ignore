if exists("g:vim_ignore")
  finish
endif
let g:vim_ignore = 1

""
" @section Introduction, intro
" This plugin is intended to parse a .gitignore file and make a string of
" ignored files/paths available for a variety of other plugins. The initial
" goal was for use with 'find' with the fzf plugin and NERDTree.
"
" Feel free to contribute or improve this by following the contributing
" guidelines at
" https://github.com/dewyze/vim-ignore/CONTRIBUTING.md

let g:ignore#default_plugins = ["NERDTree", "fzf"]

" passive plugins are turned on/available, but will only produce strings
let g:ignore#passive_plugins = []

" for active plugins, vim-ignore auto fills out their appropriate command
let g:ignore#active_plugins = []

call ignore#activate()
