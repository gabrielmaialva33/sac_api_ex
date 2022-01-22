defmodule SacApiExWeb.WebsiteController do
  use SacApiExWeb, :controller

  alias SacApiEx.Websites.Repositories.WebsitesRepository
  alias SacApiEx.Websites.Models.Website
  alias Flop

  plug :put_view, SacApiExWeb.WebsiteView
  action_fallback SacApiExWeb.FallbackController

  def index(conn, params) do
    with {:ok, flop} <- Flop.validate(params, for: Website) do
      {:ok, {websites, meta}} = WebsitesRepository.list_websites(flop)
      render(conn, "index.json", %{websites: websites, meta: meta})
    end
  end

  def show(conn, %{"id" => id}) do
    website = WebsitesRepository.get_website!(id)
    render(conn, "show.json", website: website)
  end

  def create(conn, %{"website" => website_params}) do
    with {:ok, %Website{} = website} <- WebsitesRepository.create_website(website_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.website_path(conn, :show, website))
      |> render("show.json", website: website)
    end
  end

  def update(conn, %{"id" => id, "website" => website_params}) do
    website = WebsitesRepository.get_website!(id)

    with {:ok, %Website{} = website} <- WebsitesRepository.update_website(website, website_params) do
      render(conn, "show.json", website: website)
    end
  end

  def delete(conn, %{"id" => id}) do
    website = WebsitesRepository.get_website!(id)

    with {:ok, %Website{}} <- WebsitesRepository.delete_website(website) do
      send_resp(conn, :no_content, "")
    end
  end
end
