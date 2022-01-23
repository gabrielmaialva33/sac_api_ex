defmodule SacApiExWeb.RoleView do
  use SacApiExWeb, :view

  alias Flop
  alias SacApiExWeb.RoleView
  alias SacApiExWeb.MetaView

  def render("index.json", %{roles: roles, meta: meta}) do
    %{
      data: render_many(roles, RoleView, "role.json"),
      __meta__: MetaView.render("meta.json", %{meta: meta})
    }
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{
      id: role.id,
      slug: role.slug,
      # name: role.name,
      description: role.description
    }
  end
end
