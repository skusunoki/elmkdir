defmodule Elmkdir.Directory do
  @moduledoc """
  Create a directory with the generated folder name.
  """
alias Elmkdir.DateTime

  @spec create_folder(DateTime.t(), String.t()) :: String.t()
  def create_folder(now, leaf_folder_base_name) do
    1..5
    |> Enum.map( fn idx -> Enum.take( generate_folder_list(now, leaf_folder_base_name), idx) end )
    |> Enum.map( fn folder_elem -> Enum.join(folder_elem, "/") end )
    |> tap(&ensure_folder_exists(&1))
    |> List.last()

  end

  @spec generate_folder_list( DateTime.t(), String.t() ) :: [ String.t() ]
  def generate_folder_list(now, leaf_base_name) do
    [ Elmkdir.Config.parent_dir(),
      Elmkdir.DateTime.to_year(now),
      Elmkdir.DateTime.to_period(now),
      "W" <> Elmkdir.DateTime.to_week(now),
      Elmkdir.DateTime.to_yyyymmddhhMMss(now) <> "_" <> leaf_base_name
    ]
  end

  def ensure_folder_exists([head|tail]) do
    head
    |> File.exists?()
    |> case do
      true -> :ok
      false -> File.mkdir(head)
    end

    ensure_folder_exists(tail)
  end
  def ensure_folder_exists([]), do: :ok

end
