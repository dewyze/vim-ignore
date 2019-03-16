function! ignore#converters#nerdtree#ignore_array(map) abort
  let l:result = []
  for dir in a:map["dirs"]
    let l:result = l:result + [ignore#converters#nerdtree#escape(dir)]
  endfor
  for file in a:map["files"]
    let l:result = l:result + [ignore#converters#nerdtree#escape(file)]
  endfor
  return '\%(' . join(l:result, '\|') . '\)'
endfunction

function! ignore#converters#nerdtree#escape(item) abort
  return '^' . escape(a:item, './')
endfunction
