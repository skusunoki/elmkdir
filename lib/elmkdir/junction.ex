defmodule Elmkdir.Junction do
  def create_junction(full_path, now, folder, code) do
    link_dir = Elmkdir.Config.folder_jdex_inbox_dir(code)
    link_path = link_dir <> "/" <> "#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}"
    
    Elmkdir.System.create_junction_link(full_path, link_path)
    Elmkdir.System.to_win_path(link_dir)
  end
end
