ExUnit.start()
Mix.shell(Mix.Shell.Process)
Application.put_env(:app, :colors, [enabled: false])

defmodule EkTestCase.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import EkTestCase.Case
    end
  end

  setup do
    on_exit fn ->
      System.put_env("MIX_HOME", tmp_path(".mix"))
      delete_tmp_paths
    end

    :ok
  end

  def tmp_path do
    Path.expand("../tmp", __DIR__)
  end

  def tmp_path(extension) do
    Path.join tmp_path, extension
  end

  def in_tmp(which, function) do
    path = tmp_path(which)
    File.rm_rf! path
    File.mkdir_p! path
    File.cd! path, function
  end

  defp delete_tmp_paths do
    tmp = tmp_path |> String.to_char_list
    for path <- :code.get_path,
        :string.str(path, tmp) != 0,
        do: :code.del_path(path)
  end
end
