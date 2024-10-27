defmodule Elmkdir.Shortcut do
    @base Mix.Project.app_path()
    @vbs "/priv/vbs/shortcut.vbs"

  def create_shortcut(full_path, now, folder, code) do
    with full_path_win <- String.replace(full_path, "/", "\\"),
    vbs_win <- String.replace(path_to_vbs(), "/", "\\"),
    link_dir_win <- String.replace(Elmkdir.Config.folder_jdex_inbox_dir(code), "/", "\\") do
      System.cmd("cmd.exe", [
        "/c",
        "cscript",
        vbs_win,
        link_dir_win,
        full_path_win,
        "#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}"
      ])
      link_dir_win
    end
  end

  def create_shortcut(full_path, now, folder, code, file) do
    create_shortcut(full_path <> "/" <> file, now, folder, code)
    String.replace(Elmkdir.Config.folder_jdex_inbox_dir(code), "/", "\\")
  end

  defp path_to_vbs() do
    @base <> @vbs
  end
end
