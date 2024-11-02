defmodule Elmkdir.Shortcut do
  def create_shortcut(full_path, now, folder, code) do
    with full_path_win <- String.replace(full_path, "/", "\\"),
         link_dir_win <- String.replace(Elmkdir.Config.folder_jdex_inbox_dir(code), "/", "\\") do
      System.cmd("cmd.exe", [
        "/c",
        "mklink",
        "/J",
        link_dir_win <> "\\" <> "#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}",
        full_path_win
      ])

      link_dir_win
    end
  end
end
