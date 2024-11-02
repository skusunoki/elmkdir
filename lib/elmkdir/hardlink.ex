defmodule Elmkdir.Hardlink do
  def create_hardlink(full_path, now, folder, code) do
    with hardlink_target = full_path |> to_win(),
         link_dir = Elmkdir.Config.folder_jdex_inbox_dir(code) |> to_win(),
         hardlink_file_name =
           (link_dir <> "/" <> hardlink_filename(full_path, now, folder, code))
           |> to_win(),
         {_, 0} <-
           System.cmd("cmd.exe", ["/c", "mklink", "/H", hardlink_file_name, hardlink_target]) do
      link_dir
    else
      _ -> raise "Failed to create a hardlink"
    end
  end

  def create_hardlink(full_path, now, folder, code, file) do
    create_hardlink(full_path <> "/" <> file, now, folder, code)
    Elmkdir.Config.folder_jdex_inbox_dir(code) |> to_win()
  end

  def hardlink_filename(_full_path, now, nil, _code) do
    "#{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_month(now)}-#{Elmkdir.DateTime.to_day(now)}.md"
  end

  def hardlink_filename(full_path, now, folder, code) do
    case folder do
      "" ->
        hardlink_filename(full_path, now, nil, code)

      folder ->
        "#{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_month(now)}-#{Elmkdir.DateTime.to_day(now)}_#{folder}.md"
    end
  end

  def to_win(path) do
    path |> String.replace("/", "\\")
  end
end
