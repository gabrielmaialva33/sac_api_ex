defmodule SacApiExWeb.WebsiteView do
  use SacApiExWeb, :view
  alias SacApiExWeb.WebsiteView

  def render("index.json", %{websites: websites}) do
    %{data: render_many(websites, WebsiteView, "website.json")}
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
      is_deleted: website.is_deleted
    }
  end
end
