function! ignore#sources#gitignore#ignore_map(lines) abort
  let l:dirs = []
  let l:files = []
  let l:comments = []
  let l:blanks = []

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
let s:glob_slash_pattern = '\(.*\(\*\|\/\)\)'
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

function! ignore#sources#gitignore#exact_filename(line) abort
  " '^\(.*\(\*\|\/\)\)\@!.*$'
  let l:exact_filename_pattern =
        \ s:beginning_of_line_pattern .
        \ s:glob_slash_pattern . s:ignore_pattern .
        \ s:wildcard_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:exact_filename_pattern
endfunction

function! ignore#sources#gitignore#exact_filepath(line) abort
" '^\(.*\*\)\@!.*$'
  let l:exact_filepath_pattern =
        \ s:beginning_of_line_pattern .
        \ s:glob_pattern . s:ignore_pattern .
        \ s:wildcard_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:exact_filepath_pattern
endfunction

function! ignore#sources#gitignore#exact_directory(line) abort
  " '^\(.*\*\)\@!.*$'
  let l:exact_directory_pattern =
        \ s:beginning_of_line_pattern .
        \ s:glob_pattern . s:ignore_pattern .
        \ s:wildcard_pattern .
        \ s:forward_slash_pattern .
        \ s:end_of_line_pattern
  return a:line =~ l:exact_directory_pattern
endfunction

function! ignore#sources#gitignore#wildcard_path(line) abort
  " WRONG '^\(.*\*\)\@!.*$'
  " let l:wildcard_path_pattern =
  "       \ s:beginning_of_line_pattern .
  "       \ s:glob_pattern . s:ignore_pattern .
  "       \ s:wildcard_pattern .
  "       \ s:forward_slash_pattern .
  "       \ s:end_of_line_pattern
  return a:line =~ l:wildcard_path_pattern
endfunction

" function! ignore#sources#gitignore#wildcard_path(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" function! ignore#sources#gitignore#root_wildcard_path(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" function! ignore#sources#gitignore#wildcard_path(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" function! ignore#sources#gitignore#leading_double_wildcard(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" function! ignore#sources#gitignore#trailing_double_wildcard(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" function! ignore#sources#gitignore#path_double_wildcard(line) abort
" file with slashes, no globs, match any file at the path from the root level
" endfunction

" GITIGNORE SPEC
" [X] A blank line matches no files, so it can serve as a separator for readability.
" FUNCTION: function! ignore#sources#gitignore#blank(line) abort
"
" [X] A line starting with # serves as a comment. Put a backslash ("\") in front of the first hash for patterns that begin with a hash.
" FUNCTION: function! ignore#sources#gitignore#comment(line) abort
"
" Trailing spaces are ignored unless they are quoted with backslash ("\").
"
" An optional prefix "!" which negates the pattern; any matching file excluded by a previous pattern will become included again. It is not possible to re-include a file if a parent directory of that file is excluded. Git doesn’t list excluded directories for performance reasons, so any patterns on contained files have no effect, no matter where they are defined. Put a backslash ("\") in front of the first "!" for patterns that begin with a literal "!", for example, "\!important!.txt".
"
" If the pattern ends with a slash, it is removed for the purpose of the following description, but it would only find a match with a directory. In other words, foo/ will match a directory foo and paths underneath it, but will not match a regular file or a symbolic link foo (this is consistent with the way how pathspec works in general in Git).
" FUNCTION: function! ignore#sources#gitignore#exact_directory(line) abort
"
" [X] If the pattern does not contain a slash /, Git treats it as a shell glob pattern and checks for a match against the pathname relative to the location of the .gitignore file (relative to the toplevel of the work tree if not from a .gitignore file).
" FUNCTION: function! ignore#sources#gitignore#exact_filename(line) abort
"
" Otherwise, Git treats the pattern as a shell glob: "*" matches anything except "/", "?" matches any one character except "/" and "[]" matches one character in a selected range. See fnmatch(3) and the FNM_PATHNAME flag for a more detailed description.
" [X] FUNCTION: function! ignore#sources#gitignore#exact_filepath(line) abort
" AND
" FUNCTION: function! ignore#sources#gitignore#wildcard_path(line) abort
"
"
" A leading slash matches the beginning of the pathname. For example, "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
" FUNCTION: function! ignore#sources#gitignore#root_wildcard_path(line) abort
"
" Two consecutive asterisks ("**") in patterns matched against full pathname may have special meaning:
"
" A leading "**" followed by a slash means match in all directories. For example, "**/foo" matches file or directory "foo" anywhere, the same as pattern "foo". "**/foo/bar" matches file or directory "bar" anywhere that is directly under directory "foo".
" FUNCTION: function! ignore#sources#gitignore#leading_double_wildcard(line) abort
"
" A trailing "/**" matches everything inside. For example, "abc/**" matches all files inside directory "abc", relative to the location of the .gitignore file, with infinite depth.
" FUNCTION: function! ignore#sources#gitignore#trailing_double_wildcard(line) abort
"
" A slash followed by two consecutive asterisks then a slash matches zero or more directories. For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y/b" and so on.
" FUNCTION: function! ignore#sources#gitignore#path_double_wildcard(line) abort
"
" Other consecutive asterisks are considered regular asterisks and will match according to the previous rules.
" FUNCTION: function! ignore#sources#gitignore#wildcard_path(line) abort
