defmodule Elmkdir.Note.LinkFile do
  @external_resource "priv/template/template_linkfile.md"
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
    new_file = Elmkdir.Config.folder_link_file_dir() <> "/" <> Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> ".md"
    hardlink_file_path = full_path <> "/" <> hardlink_filename(now, folder)
    
    case Elmkdir.System.create_hardlink(new_file, hardlink_file_path) do
      {_, 0} -> full_path
      _ -> raise "Failed to create a hardlink"
    end
  end


  def hardlink_filename(now, folder) do
    Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> "_" <> folder <> ".md"
  end
end
