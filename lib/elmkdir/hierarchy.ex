defmodule Hierarchy do
  @doc """
  ## Example

      iex> Hierarchy.recurse([1,2,3])
      [[1],[1,2],[1,2,3]]

      iex> Hierarchy.recurse([1])
      [[1]]
  """

  @spec recurse(Enum.t()) :: [list()]
  def recurse(enum) do
    recurse(Enum.reverse(enum), [])
  end

  @spec recurse(list(), [list()]) :: [list()]
  def recurse([], acc), do: acc

  @spec recurse(list(), [list()]) :: [list()]
  def recurse([head | tail], acc) do
    recurse(tail, [Enum.reverse([head | tail])|acc])
  end

  @doc """
  ### Example

      iex> Hierarchy.recursive_function([1,2,3], 0, fn x, acc -> acc + x end)
      [1, 3, 6]

      iex> Hierarchy.recursive_function([1,2,3], 1, fn x, acc -> acc * x end)
      [1, 2, 6]

      iex> Hierarchy.recursive_function(["Users", "doe", "Documents", "file.text"], "c:", fn x, acc -> Enum.join([acc, x], "/" ) end)
      ["c:/Users", "c:/Users/doe", "c:/Users/doe/Documents", "c:/Users/doe/Documents/file.text"]
  """
  @spec recursive_function(Enum.t(), any(), ((any(), any()) -> any())) :: [any()]
  def recursive_function(list, acc, function)  do
    recurse(list)
    |> Enum.map( fn list -> Enum.reduce(list, acc, function) end)
  end

  @spec recursive_function(Enum.t(), ((any(), any()) -> any())) :: [any()]
  def recursive_function(list, function)  do
    recurse(list)
    |> Enum.map( fn list -> Enum.reduce(list, function) end)
  end

end
