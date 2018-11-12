describe "ignore#converters#grep#ignore_string"
  it "returns a greppable string"
    let map = {
          \ "dirs": ["foo/", "foo/bar/", "my dir/"],
          \ "files": ["foo.txt", "foo/bar.txt", "my file.txt"],
          \ }
    let result = 'foo\/|foo\/bar\/|my dir\/|foo\.txt|foo\/bar\.txt|my file\.txt'

    Expect ignore#converters#grep#ignore_string(map) == result
  end
end

describe "ignore#converters#grep#escape"
  it "escapes slashes and dots"
    Expect ignore#converters#grep#escape("foo/bar.txt") == 'foo\/bar\.txt'
  end
end

describe "ignore#converters#grep#escape_slashes"
  it "escapes a slash in a directory"
    Expect ignore#converters#grep#escape_slashes("tmp/") == 'tmp\/'
  end

  it "escapes a slash in a file"
    Expect ignore#converters#grep#escape_slashes("foo/bar.txt") == 'foo\/bar.txt'
  end

  it "escapes multiple slashes"
    Expect ignore#converters#grep#escape_slashes("foo/bar/") == 'foo\/bar\/'
  end
end

describe "ignore#converters#grep#escape_dots"
  it "escapes dots"
    Expect ignore#converters#grep#escape_dots("foo.txt") == 'foo\.txt'
  end

  it "escapes multipl dots in file"
    Expect ignore#converters#grep#escape_dots("foo.txt") == 'foo\.txt'
  end
end
