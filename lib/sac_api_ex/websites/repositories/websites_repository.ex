defmodule SacApiEx.Websites.Repositories.WebsitesRepository do
  @moduledoc """
  The Websites context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias SacApiEx.{Repo, Websites.Models.Website}
  alias Flop

  @doc """
  Returns the list of websites.

  ## Examples

      iex> list_websites()
      [%Website{}, ...]

  """
  @spec list_websites(Flop.t()) ::
          {:ok, {[Website.t()], Flop.Meta.t()}} | {:error, Changeset.t()}
  def list_websites(flop \\ %Flop{}) do
    query = from w in Website, where: w.is_deleted != true, order_by: w.title
    Flop.validate_and_run(query, flop, for: Website, repo: Repo)
  end

  @doc """
  Gets a single website.

  Raises `Ecto.NoResultsError` if the Website does not exist.

  ## Examples

      iex> get_website!(123)
      %Website{}

      iex> get_website!(456)
      ** (Ecto.NoResultsError)

  """
  def get_website!(id), do: Repo.get!(Website, id)

  @doc """
  Creates a website.

  ## Examples

      iex> create_website(%{field: value})
      {:ok, %Website{}}

      iex> create_website(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_website(attrs \\ %{}) do
    %Website{}
    |> Website.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a website.

  ## Examples

      iex> update_website(website, %{field: new_value})
      {:ok, %Website{}}

      iex> update_website(website, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_website(%Website{} = website, attrs) do
    website
    |> Website.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a website.

  ## Examples

      iex> delete_website(website)
      {:ok, %Website{}}

      iex> delete_website(website)
      {:error, %Ecto.Changeset{}}

  """
  def delete_website(%Website{} = website) do
    Repo.delete(website)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking website changes.

  ## Examples

      iex> change_website(website)
      %Ecto.Changeset{data: %Website{}}

  """
  def change_website(%Website{} = website, attrs \\ %{}) do
    Website.changeset(website, attrs)
  end
end
