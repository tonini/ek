defmodule CLITest do
  use ExUnit.Case

  import Ek.CLI, only: [ parse_args: 1, main: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"])     == :help
    assert parse_args(["--help"]) == :help
  end

  test "package name and options returned" do
    assert parse_args(["package_name", "-b", "-t"]) == {"package_name", [bin: true, test: true]}
  end

  test ":version returned by option parsing with -v and --version options" do
    assert parse_args(["-v"]) == :version
    assert parse_args(["--version"]) == :version
  end
end
