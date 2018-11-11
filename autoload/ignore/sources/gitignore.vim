function! ignore#sources#gitignore#parse_file(lines) abort
  let l:dirs = []
  let l:files = []
  let l:comments = []
  let l:blanks = []
  " TODO: let l:globs = []
  " TODO: let l:negations = []

  for l:line in a:lines
    if ignore#sources#gitignore#blank(l:line) || ignore#sources#gitignore#comment(l:line)
      continue
    elseif ignore#sources#gitignore#directory(l:line)
      let l:dirs = l:dirs + [l:line]
    elseif ignore#sources#gitignore#file(l:line)
      let l:files = l:files + [l:line]
    endif
  endfor
  return {
        \ "dirs": l:dirs,
        \ "files": l:files,
        \ }
endfunction

let s:beginning_of_line_pattern = '^'
let s:whitespace_pattern = '\s*'
let s:glob_pattern = '\(.*\*\)'
let s:ignore_pattern = '\@!'
let s:ignore_post_pattern = '\@<!'
let s:wildcard_pattern = '.*'
let s:forward_slash_pattern = '\(\/\)'
let s:end_of_line_pattern = '$'

function! ignore#sources#gitignore#blank(line) abort
  " '^\s*$'
  let l:blank_line_pattern =
        \ s:beginning_of_line_pattern .
        \ s:whitespace_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:blank_line_pattern
endfunction

function! ignore#sources#gitignore#comment(line) abort
  " '^\s*#'
  let l:comment_pattern =
        \ s:beginning_of_line_pattern .
        \ s:whitespace_pattern .
        \ '#'
  return a:line =~ l:comment_pattern
endfunction

function! ignore#sources#gitignore#directory(line) abort
  " '^\(.*\*\)\@!.*\(\/\)$'
  let l:directory_pattern =
        \ s:beginning_of_line_pattern .
        \ s:glob_pattern . s:ignore_pattern .
        \ s:wildcard_pattern .
        \ s:forward_slash_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:directory_pattern
endfunction

function! ignore#sources#gitignore#file(line) abort
  " '^\(.*\*\)\@!.*\(\/\)\!@<!$'
  let l:file_pattern =
        \ s:beginning_of_line_pattern .
        \ s:glob_pattern . s:ignore_pattern .
        \ s:wildcard_pattern .
        \ s:forward_slash_pattern . s:ignore_post_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:file_pattern
endfunction
