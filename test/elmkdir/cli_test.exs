defmodule ElmkdirCLITest do
  use ExUnit.Case
  doctest Elmkdir.CLI

  import Elmkdir.CLI, only: [parse_args: 1]

  test ":help retruned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "one value returned if one given" do
    assert parse_args(["folder_name"]) == {%{}, "folder_name"}
  end

  test ":explorer returned by option parsing with -e and --explorer options" do
    assert parse_args(["-e", "folder_name"]) == {%{:explorer => true}, "folder_name"}
    assert parse_args(["--explorer", "folder_name"]) == {%{:explorer => true}, "folder_name"}
  end

  test ":code returned by option parsing with -c and --code options" do
    assert parse_args(["-c", "folder_name"]) == {%{:code => true}, "folder_name"}
    assert parse_args(["--code", "folder_name"]) == {%{:code => true}, "folder_name"}
  end

  test "both :code and :explorer returned by option parsing with -e and --c options" do
    assert parse_args(["-c", "-e", "folder_name"]) ==
             {%{:code => true, :explorer => true}, "folder_name"}

    assert parse_args(["-e", "-c", "folder_name"]) ==
             {%{:code => true, :explorer => true}, "folder_name"}

    assert parse_args(["--explorer", "--code", "folder_name"]) ==
             {%{:code => true, :explorer => true}, "folder_name"}

    assert parse_args(["--code", "--explorer", "folder_name"]) ==
             {%{:code => true, :explorer => true}, "folder_name"}
  end

  test ":help returned by option parsing with both -h and -c" do
    assert parse_args(["-h", "-c", "folder_name"]) == :help
  end
end
