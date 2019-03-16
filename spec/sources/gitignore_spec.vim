describe "ignore#sources#gitignore#ignore_map"
  it "returns a map with the directories and files broken up"
    let lines = ["dir/", "file.txt", "# comment", "   "]
    let ignore_map = ignore#sources#gitignore#ignore_map(lines)

    Expect keys(ignore_map) == ["dirs", "files"]
    Expect ignore_map["dirs"] == ["dir/"]
    Expect ignore_map["files"] == ["file.txt"]
  end
end

describe "ignore#sources#gitignore#blank"
  it 'returns true for whitespace and empty lines'
    Expect ignore#sources#gitignore#blank("") toBeTrue
    Expect ignore#sources#gitignore#blank("   ") toBeTrue
    Expect ignore#sources#gitignore#blank("\t   ") toBeTrue
  end

  it "returns false for strings or newlines"
    Expect ignore#sources#gitignore#blank("\n") toBeFalse
    Expect ignore#sources#gitignore#blank(" \\ ") toBeFalse
    Expect ignore#sources#gitignore#blank("#  ") toBeFalse
  end
end

describe "ignore#sources#gitignore#comment"
  it 'returns true for comments'
    let l = "# This is a comment #"
    Expect ignore#sources#gitignore#comment(l) toBeTrue
    Expect ignore#sources#gitignore#comment("#") toBeTrue
    Expect ignore#sources#gitignore#comment(" #  ") toBeTrue
  end

  it "returns false for non comments"
    let c1 = "\" vim comment"
    let c2 = "\\# vim comment"
    let c3 = "!something.txt"
    Expect ignore#sources#gitignore#comment(c1) toBeFalse
    Expect ignore#sources#gitignore#comment(c2) toBeFalse
    Expect ignore#sources#gitignore#comment(c3) toBeFalse
  end
end

describe "ignore#sources#gitignore#directory"
  it 'returns true for directories that in in "/"'
    Expect ignore#sources#gitignore#directory("foo/") toBeTrue
    Expect ignore#sources#gitignore#directory("foo/bar/") toBeTrue
    Expect ignore#sources#gitignore#directory("/foo/bar/baz/") toBeTrue
  end

  it "returns false for non directories or directories with globs"
    Expect ignore#sources#gitignore#directory("foo.txt") toBeFalse
    Expect ignore#sources#gitignore#directory("foo/bar") toBeFalse
    Expect ignore#sources#gitignore#directory("foo/*") toBeFalse
    Expect ignore#sources#gitignore#directory("*/foo/") toBeFalse
  end
end

describe "ignore#sources#gitignore#file"
  it 'returns true for non-glob files'
    Expect ignore#sources#gitignore#file("foo") toBeTrue
    Expect ignore#sources#gitignore#file("foo/bar") toBeTrue
    Expect ignore#sources#gitignore#file("foo.txt") toBeTrue
  end

  it "returns false for glob files"
    Expect ignore#sources#gitignore#file("*foo.txt") toBeFalse
    Expect ignore#sources#gitignore#file("foo/*/bar.txt") toBeFalse
    Expect ignore#sources#gitignore#file("foo/") toBeFalse
  end
end
