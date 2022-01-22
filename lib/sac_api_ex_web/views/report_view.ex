defmodule SacApiExWeb.ReportView do
  use SacApiExWeb, :view
  alias SacApiExWeb.ReportView

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{
      id: report.id,
      trouble_id: report.trouble_id,
      is_reported: report.is_reported,
      inserted_at: report.inserted_at
    }
  end
end
