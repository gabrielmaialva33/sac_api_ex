defmodule SacApiExWeb.WebsiteView do
  use SacApiExWeb, :view

  alias Flop
  alias SacApiExWeb.WebsiteView
  alias SacApiExWeb.TroubleView
  alias SacApiExWeb.MetaView

  def render("index.json", %{websites: websites, meta: meta}) do
    %{
      data: render_many(websites, WebsiteView, "website.json"),
      __meta__: MetaView.render("meta.json", %{meta: meta})
    }
  end

  def render("show.json", %{website: website}) do
    %{data: render_one(website, WebsiteView, "website.json")}
  end

  def render("website.json", %{website: website}) do
    %{
      id: website.id,
      title: website.title,
      description: website.description,
      url: website.url,
      troubles: render_many(website.troubles, TroubleView, "trouble.json")
    }
  end
end
