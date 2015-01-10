defmodule Ek.CLI do

  def run(argv) do
    parse_args(argv)
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               switches: [help: :boolean],
                               aliases:  [h: :help, b: :bin])

    case parse do
      {[help: true], _, _} -> :help
      {opts, [name|_], _}  -> {name, opts}
      _ -> :help
    end
  end

  def process(name, opts) do
    Ek.generate_pkg(name, opts)
  end

  def process(:help) do
    IO.write """
    usage:
      ek new PATH [OPTIONS]

    Options:
      -b, --bin   Generate a binary directory for your package
      -t, --test  Generate a test directory for your package

    Creates a skeleton for creating an emacs package
    """
    exit {:shutdown, 1}
  end

end
