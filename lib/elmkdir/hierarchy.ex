defmodule Hierarchy do
  @doc """
  ## Example

      iex> Hierarchy.build_cumulative([1,2,3])
      [[1],[1,2],[1,2,3]]

      iex> Hierarchy.build_cumulative([1])
      [[1]]
  """

  @spec build_cumulative(Enum.t()) :: [list]
  def build_cumulative(enum) do
    build_cumulative(Enum.reverse(enum), [])
  end

  @spec build_cumulative(list, [list]) :: [list]
  def build_cumulative([], acc), do: acc

  @spec build_cumulative(list, [list]) :: [list]
  def build_cumulative([head | tail], acc) do
    build_cumulative(tail, [Enum.reverse([head | tail]) | acc])
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
  @spec recursive_function(Enum.t(), any, (any, any -> any)) :: [any]
  def recursive_function(list, acc, function) do
    build_cumulative(list)
    |> Enum.map(fn list -> Enum.reduce(list, acc, function) end)
  end

  @spec recursive_function(Enum.t(), (any, any -> any)) :: [any]
  def recursive_function(list, function) do
    build_cumulative(list)
    |> Enum.map(fn list -> Enum.reduce(list, function) end)
  end
end
