function! ignore#activate() abort
  let g:vimignore_ignore_map = ignore#parse()
  call ignore#plugins#nerdtree#activate()
endfunction

function! ignore#parse() abort
  " TODO: Allow different types of ignore files
  " Use default of gitignore
  let s:ignore_map = {}
  if filereadable(glob(".gitignore"))
    let l:lines = readfile(".gitignore")
    let s:ignore_map = ignore#sources#gitignore#ignore_map(lines)
  end
  return s:ignore_map
endfunction
