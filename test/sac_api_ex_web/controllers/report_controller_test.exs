defmodule SacApiExWeb.ReportControllerTest do
  use SacApiExWeb.ConnCase

  import SacApiEx.TroublesFixtures

  alias SacApiEx.Troubles.Report

  @create_attrs %{
    is_reported: true
  }
  @update_attrs %{
    is_reported: false
  }
  @invalid_attrs %{is_reported: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reports", %{conn: conn} do
      conn = get(conn, Routes.report_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create report" do
    test "renders report when data is valid", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), report: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.report_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "is_reported" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.report_path(conn, :create), report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update report" do
    setup [:create_report]

    test "renders report when data is valid", %{conn: conn, report: %Report{id: id} = report} do
      conn = put(conn, Routes.report_path(conn, :update, report), report: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.report_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "is_reported" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, report: report} do
      conn = put(conn, Routes.report_path(conn, :update, report), report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete report" do
    setup [:create_report]

    test "deletes chosen report", %{conn: conn, report: report} do
      conn = delete(conn, Routes.report_path(conn, :delete, report))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.report_path(conn, :show, report))
      end
    end
  end

  defp create_report(_) do
    report = report_fixture()
    %{report: report}
  end
end
