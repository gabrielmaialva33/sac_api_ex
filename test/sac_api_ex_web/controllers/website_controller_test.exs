defmodule SacApiExWeb.WebsiteControllerTest do
  use SacApiExWeb.ConnCase

  import SacApiEx.WebsitesFixtures

  alias SacApiEx.Websites.Website

  @create_attrs %{
    description: "some description",
    is_deleted: true,
    title: "some title",
    url: "some url"
  }
  @update_attrs %{
    description: "some updated description",
    is_deleted: false,
    title: "some updated title",
    url: "some updated url"
  }
  @invalid_attrs %{description: nil, is_deleted: nil, title: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all websites", %{conn: conn} do
      conn = get(conn, Routes.website_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create website" do
    test "renders website when data is valid", %{conn: conn} do
      conn = post(conn, Routes.website_path(conn, :create), website: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.website_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "is_deleted" => true,
               "title" => "some title",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.website_path(conn, :create), website: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update website" do
    setup [:create_website]

    test "renders website when data is valid", %{conn: conn, website: %Website{id: id} = website} do
      conn = put(conn, Routes.website_path(conn, :update, website), website: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.website_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "is_deleted" => false,
               "title" => "some updated title",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, website: website} do
      conn = put(conn, Routes.website_path(conn, :update, website), website: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete website" do
    setup [:create_website]

    test "deletes chosen website", %{conn: conn, website: website} do
      conn = delete(conn, Routes.website_path(conn, :delete, website))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.website_path(conn, :show, website))
      end
    end
  end

  defp create_website(_) do
    website = website_fixture()
    %{website: website}
  end
end
