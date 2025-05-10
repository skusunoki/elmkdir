defmodule Elmkdir.Note do
  @template_content File.read!("priv/template/template_note.md")
  def create_note(full_path, now, note_name) do
    new_file =
      full_path <> "/" <> Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> "_" <> note_name <> ".md"

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
      |> String.replace("{{note_name}}", note_name)


    File.write!(new_file, content)
  end
end
