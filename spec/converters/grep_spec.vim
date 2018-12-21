describe "ignore#converters#grep#ignore_flags"
  it "returns a greppable string"
    let map = {
          \ "dirs": ["foo/", "foo/bar/", "my dir/"],
          \ "files": ["foo.txt", "foo/bar.txt", "my file.txt"],
          \ }
    let result = 'foo\/|foo\/bar\/|my dir\/|foo\.txt|foo\/bar\.txt|my file\.txt'

    Expect ignore#converters#grep#ignore_flags(map) == result
  end
end

describe "ignore#converters#grep#escape"
  it "escapes slashes and dots"
    Expect ignore#converters#grep#escape("foo/bar.txt") == 'foo\/bar\.txt'
  end
end
