defmodule SacApiExWeb.RoleController do
  use SacApiExWeb, :controller

  alias SacApiEx.User.Repositories.RolesRepository
  alias SacApiEx.User.Models.Role
  alias Flop

  plug :put_view, SacApiExWeb.RoleView
  action_fallback SacApiExWeb.FallbackController

  def index(conn, params) do
    with {:ok, flop} <- Flop.validate(params, for: Role) do
      {:ok, {roles, meta}} = RolesRepository.list_roles(flop)
      render(conn, "index.json", %{roles: roles, meta: meta})
    end
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- RolesRepository.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = RolesRepository.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = RolesRepository.get_role!(id)

    with {:ok, %Role{} = role} <- RolesRepository.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = RolesRepository.get_role!(id)

    with {:ok, %Role{}} <- RolesRepository.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
