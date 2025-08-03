defmodule Elmkdir.Opener.Code do
  def open_folder_by_vscode(full_path) do
    full_path
    |> tap(&Elmkdir.System.open_vscode(&1))
  end
end
