defmodule SacApiExWeb.TroubleController do
  use SacApiExWeb, :controller

  alias SacApiEx.Trouble.Repositories.TroublesRepository
  alias SacApiEx.Trouble.Models.Trouble
  alias Flop

  plug :put_view, SacApiExWeb.TroubleView
  action_fallback SacApiExWeb.FallbackController

  def index(conn, params) do
    with {:ok, flop} <- Flop.validate(params, for: Trouble) do
      {:ok, {troubles, meta}} = TroublesRepository.list_troubles(flop)
      render(conn, "index.json", %{troubles: troubles, meta: meta})
    end
  end

  def create(conn, %{"trouble" => trouble_params}) do
    with {:ok, %Trouble{} = trouble} <- TroublesRepository.create_trouble(trouble_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.trouble_path(conn, :show, trouble))
      |> render("show.json", trouble: trouble)
    end
  end

  def show(conn, %{"id" => id}) do
    trouble = TroublesRepository.get_trouble!(id)
    render(conn, "show.json", trouble: trouble)
  end

  def update(conn, %{"id" => id, "trouble" => trouble_params}) do
    trouble = TroublesRepository.get_trouble!(id)

    with {:ok, %Trouble{} = trouble} <- TroublesRepository.update_trouble(trouble, trouble_params) do
      render(conn, "show.json", trouble: trouble)
    end
  end

  def delete(conn, %{"id" => id}) do
    trouble = TroublesRepository.get_trouble!(id)

    with {:ok, %Trouble{}} <- TroublesRepository.delete_trouble(trouble) do
      send_resp(conn, :no_content, "")
    end
  end
end
