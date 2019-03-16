function! g:VimIgnoreNERDTreeFilter(params)
  let pwd=expand('%:p:h')
  let fullPath=join([''] + a:params['path']['pathSegments'], '/')
  let ignore_path = ignore#converters#nerdtree#ignore_array(g:vimignore_ignore_map)

  let relativePath=substitute(fullPath, pwd . "/", '', '')
  if relativePath =~ ignore_path
    return 1
  else
    return 0
  endif
endfunction

function! ignore#plugins#nerdtree#activate() abort
  augroup vimignore
      autocmd!
      autocmd VimEnter * call NERDTreeAddPathFilter('g:VimIgnoreNERDTreeFilter')
  augroup END
endfunction
