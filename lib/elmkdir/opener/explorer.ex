defmodule Elmkdir.Opener.Explorer do
  def open_folder_in_explorer(full_path) do
    full_path
    |> tap(&Elmkdir.System.open_explorer(&1))
  end
end
