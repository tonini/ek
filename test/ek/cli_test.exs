defmodule CLITest do
  use ExUnit.Case

  import Ek.CLI, only: [ parse_args: 1, run: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h"])     == :help
    assert parse_args(["--help"]) == :help
  end

  test "" do
    assert parse_args(["package_name", "-b", "-t"]) == {"package_name", [bin: true, test: true]}
  end

end
