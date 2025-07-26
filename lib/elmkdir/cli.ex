defmodule Elmkdir.CLI do
  @moduledoc """
  Handle the command line interface for the `elmkdir` application.
  """

  @spec main([String.t()]) :: any()
  def main(argv) do
    argv
    |> Elmkdir.CLI.run()
  end

  @spec run([String.t()]) :: any()
  def run(argv) do
    argv
    |> parse_args()
    |> process()
    |> IO.inspect()
  end

  @doc """
  argv can be -h or --help, which returns :help.
  Otherwise it is a folder name.
  Optionally, argv can have -e or --explorer, which returns :explorer.
  argv can also have -c or --code, which returns :code.
  """
  def parse_args(argv) do
    argv
    |> OptionParser.parse(
      switches: [
        help: :boolean,
        explorer: :boolean,
        code: :boolean,
        daily: :boolean,
        jdex: :string,
        note: :boolean
      ],
      aliases: [h: :help, e: :explorer, c: :code, d: :daily, j: :jdex, n: :note]
    )
    |> options_to_map()
    |> args_to_internal_representation()
  end

  def options_to_map({option, argv, error}) do
    {option |> Enum.into(%{}), argv, error}
  end

  def args_to_internal_representation({%{:help => true}, _, _}) do
    :help
  end

  def args_to_internal_representation({%{:daily => true}, _, _}) do
    :daily
  end

  def args_to_internal_representation({option, [folder], _}) do
    {option, folder}
  end

  def args_to_internal_representation({%{}, [folder], _}) do
    {%{}, folder}
  end

  @spec process(any()) :: any()
  def process(:help) do
    IO.puts("""
    usage: elmkdir [options] folder

    options:
      -h  --help        show this help
      -e  --explorer    open the folder in the file explorer
      -c  --code        open the folder in the vSCode editor
      -j  --jdex        create a shortcut in the JDex inbox
      -d  --daily       create a daily folder
      -n  --note        create a note file
    """)

    System.halt(0)
  end

  def process({%{:note => true}, folder}) do
    now = Elmkdir.DateTime.now()
    jdex_code = "70.11"
    Elmkdir.Config.folder_jdex_inbox_dir(jdex_code)
    |> Elmkdir.Note.create_note(now, folder)
  end


  def process(:daily) do
    now = Elmkdir.DateTime.now()
    folder = "DAILY"
    jdex_code = "60"

    Elmkdir.Directory.create_folder(now, folder)
    |> tap(&Elmkdir.File.create_daily_index(&1, now, folder))
    |> tap(&Elmkdir.LinkFile.create_link_file(&1, now, folder))
    |> tap(&Elmkdir.Shortcut.create_shortcut(&1, now, folder, jdex_code))
    |> tap(&Elmkdir.Hardlink.create_hardlink(&1, now, folder, jdex_code, "index.md"))
    |> tap(&Elmkdir.Hardlink.create_hardlink(&1, now, folder, "70.11", "index.md"))
  end

  def process({%{:explorer => true, :code => true, :jdex => jdex_code}, folder}) do
    now = Elmkdir.DateTime.now()

    Elmkdir.Directory.create_folder(now, folder)
    |> tap(&Elmkdir.LinkFile.create_link_file(&1, now, folder))
    |> tap(&Elmkdir.Shortcut.create_shortcut(&1, now, folder, jdex_code))
    |> tap(
      &Elmkdir.Hardlink.create_hardlink(
        &1,
        now,
        folder,
        jdex_code,
        Elmkdir.LinkFile.hardlink_filename(now, folder)
      )
    )
    |> tap(&Elmkdir.Code.open_folder_by_vscode(&1))
    |> tap(&Elmkdir.Explorer.open_folder_in_explorer(&1))
  end

  def process({%{:explorer => true, :jdex => jdex_code}, folder}) do
    now = Elmkdir.DateTime.now()

    Elmkdir.Directory.create_folder(now, folder)
    |> tap(&Elmkdir.LinkFile.create_link_file(&1, now, folder))
    |> tap(&Elmkdir.Shortcut.create_shortcut(&1, now, folder, jdex_code))
    |> tap(
      &Elmkdir.Hardlink.create_hardlink(
        &1,
        now,
        folder,
        jdex_code,
        Elmkdir.LinkFile.hardlink_filename(now, folder)
      )
    )
    |> tap(&Elmkdir.Explorer.open_folder_in_explorer(&1))
  end

  def process({%{:code => true, :jdex => jdex_code}, folder}) do
    now = Elmkdir.DateTime.now()

    Elmkdir.Directory.create_folder(now, folder)
    |> tap(&Elmkdir.LinkFile.create_link_file(&1, now, folder))
    |> tap(&Elmkdir.Shortcut.create_shortcut(&1, now, folder, jdex_code))
    |> tap(
      &Elmkdir.Hardlink.create_hardlink(
        &1,
        now,
        folder,
        jdex_code,
        Elmkdir.LinkFile.hardlink_filename(now, folder)
      )
    )
    |> tap(&Elmkdir.Code.open_folder_by_vscode(&1))
  end

  def process({%{:jdex => jdex_code}, folder}) do
    now = Elmkdir.DateTime.now()

    Elmkdir.Directory.create_folder(now, folder)
    |> tap(&Elmkdir.LinkFile.create_link_file(&1, now, folder))
    |> tap(&Elmkdir.Shortcut.create_shortcut(&1, now, folder, jdex_code))
    |> tap(
      &Elmkdir.Hardlink.create_hardlink(
        &1,
        now,
        folder,
        jdex_code,
        Elmkdir.LinkFile.hardlink_filename(now, folder)
      )
    )
  end

  def process({%{:explorer => true, :code => true}, folder}) do
    process({%{:explorer => true, :code => true, :jdex => "00"}, folder})
  end

  def process({%{:explorer => true}, folder}) do
    process({%{:explorer => true, :jdex => "00"}, folder})
  end

  def process({%{:code => true}, folder}) do
    process({%{:code => true, :jdex => "00"}, folder})
  end

  def process({%{}, folder}) do
    process({%{:jdex => "00"}, folder})
  end
end
