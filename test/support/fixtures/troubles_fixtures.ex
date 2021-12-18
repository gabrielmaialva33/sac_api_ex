defmodule SacApiEx.TroublesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SacApiEx.Troubles` context.
  """

  @doc """
  Generate a trouble.
  """
  def trouble_fixture(attrs \\ %{}) do
    {:ok, trouble} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_deleted: true,
        title: "some title",
        type: "some type"
      })
      |> SacApiEx.Troubles.create_trouble()

    trouble
  end
end
