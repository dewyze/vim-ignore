" describe "ignore#converters#nerdtree#ignore_flags"
"   it "returns a nerdtree ignore array"
"     let map = {
"           \ "dirs": ["foo/", "foo/bar/", "my dir/"],
"           \ "files": ["foo.txt", "foo/bar.txt", "my file.txt"],
"           \ }
"     let result = 
"
"     Expect ignore#converters#nerdtree#ignore_string(map) == result
"   end
" end

describe "ignore#converters#nerdtree#escape_directory"
  it "removes trailing slashes and adds the [[dir]] flag"
    Expect ignore#converters#nerdtree#escape_directory("foo/") == 'foo[[dir]]'
    Expect ignore#converters#nerdtree#escape_directory("foo/bar/") == 'foo/bar[[dir]]'
  end

  it "escapes dots"
    Expect ignore#converters#nerdtree#escape_directory("foo.bar/") == 'foo\.bar[[dir]]'
    Expect ignore#converters#nerdtree#escape_directory("foo.bar/baz.bumble/") == 'foo\.bar/baz\.bumble[[dir]]'
  end
end

describe "ignore#converters#nerdtree#escape_file"
  it "adds the trailing [[file]] flag and escapes dots"
    Expect ignore#converters#nerdtree#escape_file("foo\.txt") == 'foo\.txt[[file]]'
  end

  it "adds the trailing [[file]] flag and escapes dots"
    Expect ignore#converters#nerdtree#escape_file("foo/bar\.txt") == 'foo/bar\.txt[[file]]'
  end
end
