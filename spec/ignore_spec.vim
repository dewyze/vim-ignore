source "sources/gitignore_spec.vim"

describe "ignore.vim"
  describe "ignore#parse"
    context ".gitignore file"
      before
        cd spec/fixtures/gitignore/no_glob
      end

      after
        cd -
      end

      it "works"
        let ignore_map = ignore#parse()
        Expect keys(ignore_map) == ["dirs", "files"]
        Expect ignore_map["dirs"] == ["node_modules/", "cache/test/"]
        Expect ignore_map["files"] == ["foo.txt", "tmp/bar.txt"]
      end
    end
  end
end
