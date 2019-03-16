describe "ignore#converters#nerdtree#escape"
  it "removes trailing slashes and adds the [[dir]] flag"
    Expect ignore#converters#nerdtree#escape("foo/") == '^foo\/'
    Expect ignore#converters#nerdtree#escape("foo/bar") == '^foo\/bar'
    Expect ignore#converters#nerdtree#escape("foo.o/bar/") == '^foo\.o\/bar\/'
    Expect ignore#converters#nerdtree#escape("foo.bar/baz.bumble/") == '^foo\.bar\/baz\.bumble\/'
    Expect ignore#converters#nerdtree#escape("foo.txt") == '^foo\.txt'
  end
end
