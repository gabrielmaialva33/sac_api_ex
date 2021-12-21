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

  @doc """
  Generate a website_trouble.
  """
  def website_trouble_fixture(attrs \\ %{}) do
    {:ok, website_trouble} =
      attrs
      |> Enum.into(%{
        trouble_id: "some trouble_id",
        website_id: "some website_id"
      })
      |> SacApiEx.Websites.create_website_trouble()

    website_trouble
  end
end
