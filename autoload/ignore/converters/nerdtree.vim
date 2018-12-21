function! ignore#converters#nerdtree#ignore_string(map) abort
  let l:result = ""
  for dir in a:map["dirs"]
    let l:result = l:result . '|' . ignore#converters#nerdtree#escape_directory(dir)
  endfor
  for file in a:map["files"]
    let l:result = l:result . '|' . ignore#converters#nerdtree#escape_file(file)
  endfor
  return l:result[1:]
endfunction

function! ignore#converters#nerdtree#escape_directory(item) abort
  return escape(substitute(a:item, '\%(\/$\)', '[[dir]]', ''), '.')
endfunction

function! ignore#converters#nerdtree#escape_file(item) abort
  return escape(substitute(a:item, '\%($\)', '[[file]]', ''), '.')
endfunction
