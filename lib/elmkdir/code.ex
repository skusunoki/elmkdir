defmodule Elmkdir.Code do
  def open_folder_by_vscode(full_path) do
    full_path
    |> tap(&System.cmd("cmd.exe", ["/c", "code", &1 <> "/"]))
  end
end
