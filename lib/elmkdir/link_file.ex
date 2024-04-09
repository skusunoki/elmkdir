defmodule Elmkdir.LinkFile do

  def create_link_file(full_path, now, folder) do
    new_file = Elmkdir.Config.folder_link_file_dir() <> "/" <> Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> ".md"
    content = """
    ---
    ID: #{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}
    date: #{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_month(now)}-#{Elmkdir.DateTime.to_day(now)}
    tags: #{Elmkdir.DateTime.to_year(now)}/#{Elmkdir.DateTime.to_month(now)}/#{Elmkdir.DateTime.to_day(now)}
    aliases: [#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}]
    ---
    ### #{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_period(now)}-W#{Elmkdir.DateTime.to_week(now)}-#{folder}
    [#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}](#{full_path})

    #### History
    [[#{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_month(now)}-#{Elmkdir.DateTime.to_day(now)}]] フォルダの作成

    """
    File.write!(new_file, content)
  end
end
