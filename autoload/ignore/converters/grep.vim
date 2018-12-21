function! ignore#converters#grep#ignore_flags(map) abort
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
  return escape(a:item, './')
endfunction
