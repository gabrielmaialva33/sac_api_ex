defmodule SacApiEx.WebsitesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SacApiEx.Websites` context.
  """

  @doc """
  Generate a website.
  """
  def website_fixture(attrs \\ %{}) do
    {:ok, website} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_deleted: true,
        title: "some title",
        url: "some url"
      })
      |> SacApiEx.Websites.create_website()

    website
  end
end
