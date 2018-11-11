function! ignore#activate() abort
  return ignore#parse()
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
