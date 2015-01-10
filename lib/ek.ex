defmodule Ek do
  import Mix.Generator

  def generate_pkg(path, opts) do
    name = Path.basename(Path.expand(path))
    File.mkdir_p!(path)

    File.cd! path, fn ->
      _generate_pkg(name, path, opts)
    end
  end

  defp _generate_pkg(name, _path, _opts) do
    assigns = [name: name]
    create_file "README.md", readme_template(assigns)
    create_file "Cask", cask_template(assigns)
    create_file ".gitignore", gitignore_text
    create_file "#{name}.el", appfile_template(assigns)
    create_file "test/test-helper.el", test_helper_template(assigns)
    create_file "test/#{name}-test.el", appfile_test_template(assigns)

    Mix.shell.info "Your emacs project was created successfully."
  end

  defp _year() do
    { year, _, _ } = :erlang.date
    year
  end

  embed_template :readme, """
  <%= @name %>
  <%= String.duplicate("=", String.length(@name)) %>

  ** TODO: Add description **
  """

  embed_template :cask, """
  (source gnu)
  (source melpa)

  (package-file "<%= @name %>.el")

  (development
    (depends-on "f")
    (depends-on "ert-runner"))
  """

  embed_text :gitignore, """
  /.cask
  *.elc
  /dist
  """

  embed_template :test_helper, """
  (require 'f)

  (defvar <%= @name %>-test-path
    (f-parent (f-this-file)))

  (defvar <%= @name %>-root-path
    (f-parent <%= @name %>-test-path))

  (require '<%= @name %> (f-expand "<%= @name %>" <%= @name %>-root-path))
  (require 'ert)

  (provide 'test-helper)
  """

  embed_template :appfile_test, """
  ;;; <%= @name %>-test.el ---

  ;; Copyright © <%= _year %>
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

  (provide '<%= @name %>-test)

  ;;; <%= @name %>-test.el ends here
  """

  embed_template :appfile, """
  ;;; <%= @name %>.el ---

  ;; Copyright © <%= _year %>
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

  (provide '<%= @name %>)

  ;;; <%= @name %>.el ends here
  """

end
