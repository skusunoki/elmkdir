defmodule Elmkdir.LinkFile do
  @template_content File.read!("priv/template/template_linkfile.md")
  def create_link_file(full_path, now, folder) do
    new_file =
      Elmkdir.Config.folder_link_file_dir() <>
        "/" <> Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> ".md"

    content =
      @template_content
      |> String.replace("{{to_yyyymmddhhMMss}}", Elmkdir.DateTime.to_yyyymmddhhMMss(now))
      |> String.replace("{{to_year}}", Elmkdir.DateTime.to_year(now))
      |> String.replace("{{to_month}}", Elmkdir.DateTime.to_month(now))
      |> String.replace("{{to_day}}", Elmkdir.DateTime.to_day(now))
      |> String.replace("{{to_hour}}", Elmkdir.DateTime.to_hour(now))
      |> String.replace("{{to_minute}}", Elmkdir.DateTime.to_minute(now))
      |> String.replace("{{to_second}}", Elmkdir.DateTime.to_second(now))
      |> String.replace("{{to_folder}}", full_path)
      |> String.replace("{{to_folder_short}}", folder)

    File.write!(new_file, content)
    create_hardlink(full_path, now, folder)
  end

  def create_hardlink(full_path, now, folder) do
    with new_file =
           (Elmkdir.Config.folder_link_file_dir() <>
              "/" <> Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> ".md")
           |> to_win(),
         hardlink_file_name = (full_path <> "/" <> hardlink_filename(now, folder)) |> to_win(),
         {_, 0} <- System.cmd("cmd.exe", ["/c", "mklink", "/H", hardlink_file_name, new_file]) do
      full_path
    else
      _ -> raise "Failed to create a hardlink"
    end
  end

  def to_win(path) do
    path |> String.replace("/", "\\")
  end

  def hardlink_filename(now, folder) do
    Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> "_" <> folder <> ".md"
  end
end
