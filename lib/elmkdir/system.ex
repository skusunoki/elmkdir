defmodule Elmkdir.System do
  @moduledoc """
  Centralized module for all system command calls.
  """

  def open_vscode(path) do
    System.cmd("cmd.exe", ["/c", "code", path <> "/"])
  end

  def open_explorer(path) do
    win_path = String.replace(path, "/", "\\")
    System.cmd("cmd.exe", ["/c", "explorer", "/root,", win_path])
  end

  def create_junction_link(target_path, link_path) do
    target_win = String.replace(target_path, "/", "\\")
    link_win = String.replace(link_path, "/", "\\")
    System.cmd("cmd.exe", ["/c", "mklink", "/J", link_win, target_win])
  end

  def create_hardlink(target_path, link_path) do
    target_win = String.replace(target_path, "/", "\\")
    link_win = String.replace(link_path, "/", "\\")
    System.cmd("cmd.exe", ["/c", "mklink", "/H", link_win, target_win])
  end

  def to_win_path(path) do
    String.replace(path, "/", "\\")
  end
end