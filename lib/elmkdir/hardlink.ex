defmodule Elmkdir.Hardlink do
  def create_hardlink(full_path, now, folder, code, opts \\ []) do
    create_hardlink_fn = opts[:create_hardlink_fn] || (&Elmkdir.System.create_hardlink/2)
    to_win_path_fn = opts[:to_win_path_fn] || (&Elmkdir.System.to_win_path/1)
    
    link_dir = Elmkdir.Config.folder_jdex_inbox_dir(code)
    hardlink_file_path = link_dir <> "/" <> hardlink_filename(full_path, now, folder, code)
    
    case create_hardlink_fn.(full_path, hardlink_file_path) do
      {_, 0} -> to_win_path_fn.(link_dir)
      _ -> raise "Failed to create a hardlink"
    end
  end

  def create_hardlink_with_file(full_path, now, folder, code, file, opts \\ []) do
    to_win_path_fn = opts[:to_win_path_fn] || (&Elmkdir.System.to_win_path/1)
    
    create_hardlink(full_path <> "/" <> file, now, folder, code, opts)
    Elmkdir.Config.folder_jdex_inbox_dir(code) |> to_win_path_fn.()
  end

  def hardlink_filename(_full_path, now, nil, _code) do
        "#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}.md"
  end

  def hardlink_filename(full_path, now, folder, code) do
    case folder do
      "" ->
        hardlink_filename(full_path, now, nil, code)

      "DAILY" ->
        "#{Elmkdir.DateTime.to_year(now)}-#{Elmkdir.DateTime.to_month(now)}-#{Elmkdir.DateTime.to_day(now)}.md"

      folder ->
        "#{Elmkdir.DateTime.to_yyyymmddhhMMss(now)}_#{folder}.md"
    end
  end

end
