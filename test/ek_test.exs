Code.require_file "test_helper.exs", __DIR__

defmodule EkTest do
  use EkTestCase.Case

  test "create a pkg file/dir skeleton" do
    in_tmp "example", fn ->
      Ek.generate_pkg("example", [])

      assert_file "example/README.md", ~r/example\n=======\n/
      assert_file "example/.gitignore", fn(content) ->
        assert content =~ "/.cask"
        assert content =~ "*.elc"
        assert content =~ "/dist"
      end

      assert_file "example/Cask", fn(content) ->
        assert content =~ """
        (source gnu)
        (source melpa)

        (package-file "example.el")

        (development
          (depends-on "f"))
        """
      end

      assert_file "example/example.el", fn(content) ->
        assert content =~ """
        ;;; example.el ---

        ;; Copyright © #{_year}
        ;;
        ;; Author:

        ;; URL:
        ;; Version: 0.1.0
        ;; Package-Requires:
        ;; Keywords:

        ;; This file is not part of GNU Emacs.

        ;; This program is free software: you can redistribute it and/or modify
        ;; it under the terms of the GNU General Public License as published by
        ;; the Free Software Foundation, either version 3 of the License, or
        ;; (at your option) any later version.

        ;; This program is distributed in the hope that it will be useful,
        ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
        ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        ;; GNU General Public License for more details.

        ;; You should have received a copy of the GNU General Public License
        ;; along with this program. If not, see <http://www.gnu.org/licenses/>.

        ;;; Commentary:

        ;;

        ;;; Code:

        (provide 'example)

        ;;; example.el ends here
        """

        assert_received {:mix_shell, :info, ["* creating Cask"]}
        assert_received {:mix_shell, :info, ["* creating README.md"]}
        assert_received {:mix_shell, :info, ["* creating example.el"]}
        assert_received {:mix_shell, :info, ["* creating .gitignore"]}
      end
    end
  end

  test "create a pkg file/dir skeleton with a test directory" do
    in_tmp "example", fn ->
      Ek.generate_pkg("example", [test: true])

      assert_file "example/Cask", fn(content) ->
        assert content =~ """
        (source gnu)
        (source melpa)

        (package-file "example.el")

        (development
          (depends-on "f")
          (depends-on "ert-runner"))
        """
      end

      assert_file "example/test/test-helper.el", fn(content) ->
        assert content =~ """
        (require 'f)

        (defvar example-test-path
          (f-parent (f-this-file)))

        (defvar example-root-path
          (f-parent example-test-path))

        (require 'example (f-expand "example" example-root-path))
        (require 'ert)

        (provide 'test-helper)
        """
      end

      assert_file "example/test/example-test.el", fn(content) ->
        assert content =~ """
        ;;; example-test.el ---

        ;; Copyright © #{_year}
        ;;
        ;; Author:

        ;; This file is not part of GNU Emacs.

        ;; This program is free software: you can redistribute it and/or modify
        ;; it under the terms of the GNU General Public License as published by
        ;; the Free Software Foundation, either version 3 of the License, or
        ;; (at your option) any later version.

        ;; This program is distributed in the hope that it will be useful,
        ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
        ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        ;; GNU General Public License for more details.

        ;; You should have received a copy of the GNU General Public License
        ;; along with this program. If not, see <http://www.gnu.org/licenses/>.

        ;;; Commentary:

        ;;

        ;;; Code:

        (provide 'example-test)

        ;;; example-test.el ends here
        """
      end

      assert_received {:mix_shell, :info, ["* creating test/test-helper.el"]}
      assert_received {:mix_shell, :info, ["* creating test/example-test.el"]}
    end
  end

    test "create a pkg file/dir skeleton with a bin directory" do
    in_tmp "example", fn ->
      Ek.generate_pkg("example", [bin: true])

      assert_received {:mix_shell, :info, ["* creating bin/example"]}
    end
  end

  defp _year() do
    { year, _, _ } = :erlang.date
    year
  end

  defp assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  defp assert_file(file, match) do
    cond do
      Regex.regex?(match) ->
        assert_file file, &(assert &1 =~ match)
      is_function(match, 1) ->
        assert_file(file)
        match.(File.read!(file))
    end
  end
end
