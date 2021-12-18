defmodule SacApiExWeb.TroubleView do
  use SacApiExWeb, :view

  alias Flop
  alias SacApiExWeb.TroubleView
  alias SacApiExWeb.MetaView

  def render("index.json", %{troubles: troubles, meta: meta}) do
    %{
      data: render_many(troubles, TroubleView, "trouble.json"),
      __meta__: MetaView.render("meta.json", %{meta: meta})
    }
  end

  def render("show.json", %{trouble: trouble}) do
    %{data: render_one(trouble, TroubleView, "trouble.json")}
  end

  def render("trouble.json", %{trouble: trouble}) do
    %{
      id: trouble.id,
      title: trouble.title,
      description: trouble.description,
      type: trouble.type,
      is_deleted: trouble.is_deleted
    }
  end
end
