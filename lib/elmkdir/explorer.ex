defmodule Elmkdir.Explorer do
  def open_folder_in_explorer( full_path ) do
    full_path
    |> String.replace("/", "\\")
    |> tap(&System.cmd("cmd.exe",["/c","explorer", "/root,", &1 ]))
  end
end
