defmodule EkTest do
  use ExUnit.Case

  import Ek.CLI, only: [ parse_args: 1, run: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"])     == :help
    assert parse_args(["--help"]) == :help
  end

  test "process :help and return an usage message" do
    assert run(["-h"]) == """
    usage:
      ek new PATH [OPTIONS]

    Options:
      -b, --bin   Generate a binary directory for your package
      -t, --test  Generate a test directory for your package

    Creates a skeleton for creating an emacs package
    """
  end

end
