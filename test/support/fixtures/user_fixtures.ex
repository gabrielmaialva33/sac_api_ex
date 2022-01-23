defmodule SacApiEx.UserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SacApiEx.User` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        slug: "some slug"
      })
      |> SacApiEx.User.create_role()

    role
  end
end
