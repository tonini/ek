defmodule Ek.CLI do

  def main(argv) do
    parse_args(argv)
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               aliases: [h: :help, b: :bin, t: :test, v: :version])

    case parse do
      {[help: true], _, _}    -> :help
      {[version: true], _, _} -> :version
      {opts, [name|_], _}     -> {name, opts}
      _                       -> :help
    end
  end

  def process({name, opts}) do
    Ek.generate_pkg(name, opts)
  end

  def process(:help) do
    IO.write """
    usage:
      ek PATH [OPTIONS]

    Options:
      -b, --bin      Generate a binary directory for your package
      -t, --test     Generate a test directory for your package
      -h, --help     Shows this help message and quit
      -v, --version  Shows ek version number and quit

    Creates a skeleton for creating an emacs package
    """
    exit {:shutdown, 1}
  end

  def process(:version) do
    Mix.shell.info "ek version #{_version}"
  end

  defp _version() do
    version = Ek.Mixfile.project[:version]
    {:ok, version} = Version.parse(version)
    "#{version.major}.#{version.minor}" <>
      case version.pre do
        [h|_] -> "-#{h}"
        []    -> ""
      end
  end

end
