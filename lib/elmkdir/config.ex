defmodule Elmkdir.Config do
  def parent_dir() do
    Application.fetch_env!(:elmkdir, :parent_dir)
  end

  def folder_link_file_dir() do
    Application.fetch_env!(:elmkdir, :folder_link_file_dir)
  end

  def folder_jdex_inbox_dir(code) do
    with folder when not is_nil(folder) <-
           Path.wildcard(
             Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir) <> "/*/*/#{code} *"
           )
           |> Enum.at(0) do
      folder
    else
      nil -> case code do
        "00" ->
          Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir_01)

        "01" ->
          Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir_01)

        "10" ->
          Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir_10)

        "50" ->
          Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir_50)

        "60" ->
          Application.fetch_env!(:elmkdir, :folder_jdex_inbox_dir_60)
        _ ->
          code
      end
    end
  end
end
