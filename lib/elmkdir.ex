defmodule Elmkdir do
  @moduledoc """
  Documentation for `Elmkdir`.
  """
  @spec main([String.t()]) :: any()
  def main(argv) do
    argv
    |> Elmkdir.CLI.run()
  end
end
