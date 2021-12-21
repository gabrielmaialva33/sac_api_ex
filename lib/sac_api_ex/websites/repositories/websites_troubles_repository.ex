defmodule SacApiEx.Websites.Repositories.WebsitesTroublesRepository do
  @moduledoc """
  The Websites context.
  """

  import Ecto.Query, warn: false
  alias SacApiEx.Repo

  alias SacApiEx.Websites.Models.WebsiteTrouble

  @doc """
  Returns the list of websites_troubles.

  ## Examples

      iex> list_websites_troubles()
      [%WebsiteTrouble{}, ...]

  """
  def list_websites_troubles do
    Repo.all(WebsiteTrouble)
  end

  @doc """
  Gets a single website_trouble.

  Raises `Ecto.NoResultsError` if the Website trouble does not exist.

  ## Examples

      iex> get_website_trouble!(123)
      %WebsiteTrouble{}

      iex> get_website_trouble!(456)
      ** (Ecto.NoResultsError)

  """
  def get_website_trouble!(id), do: Repo.get!(WebsiteTrouble, id)

  @doc """
  Creates a website_trouble.

  ## Examples

      iex> create_website_trouble(%{field: value})
      {:ok, %WebsiteTrouble{}}

      iex> create_website_trouble(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_website_trouble(attrs \\ %{}) do
    %WebsiteTrouble{}
    |> WebsiteTrouble.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a website_trouble.

  ## Examples

      iex> update_website_trouble(website_trouble, %{field: new_value})
      {:ok, %WebsiteTrouble{}}

      iex> update_website_trouble(website_trouble, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_website_trouble(%WebsiteTrouble{} = website_trouble, attrs) do
    website_trouble
    |> WebsiteTrouble.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a website_trouble.

  ## Examples

      iex> delete_website_trouble(website_trouble)
      {:ok, %WebsiteTrouble{}}

      iex> delete_website_trouble(website_trouble)
      {:error, %Ecto.Changeset{}}

  """
  def delete_website_trouble(%WebsiteTrouble{} = website_trouble) do
    Repo.delete(website_trouble)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking website_trouble changes.

  ## Examples

      iex> change_website_trouble(website_trouble)
      %Ecto.Changeset{data: %WebsiteTrouble{}}

  """
  def change_website_trouble(%WebsiteTrouble{} = website_trouble, attrs \\ %{}) do
    WebsiteTrouble.changeset(website_trouble, attrs)
  end
end
