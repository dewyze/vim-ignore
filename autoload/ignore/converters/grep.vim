function! ignore#converters#grep#ignore_string(map) abort
  let l:result = ""
  for dir in a:map["dirs"]
    let l:result = l:result . '|' . ignore#converters#grep#escape(dir)
  endfor
  for file in a:map["files"]
    let l:result = l:result . '|' . ignore#converters#grep#escape(file)
  endfor
  return l:result[1:]
endfunction

function! ignore#converters#grep#escape(item) abort
  let l:item = ignore#converters#grep#escape_slashes(a:item)
  return ignore#converters#grep#escape_dots(l:item)
endfunction

function! ignore#converters#grep#escape_slashes(item) abort
  return substitute(a:item, '\%(\/\)', '\\/', 'g')
endfunction

function! ignore#converters#grep#escape_dots(item) abort
  return substitute(a:item, '\%(\.\)', '\\.', 'g')
endfunction
