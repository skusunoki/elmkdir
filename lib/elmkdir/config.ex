defmodule Elmkdir.Config do

  def parent_dir() do
    Application.fetch_env!(:elmkdir, :parent_dir)
  end

  def folder_link_file_dir() do
    Application.fetch_env!(:elmkdir, :folder_link_file_dir)
  end


end
