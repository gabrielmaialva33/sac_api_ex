defmodule SacApiExWeb.TroubleControllerTest do
  use SacApiExWeb.ConnCase

  import SacApiEx.TroublesFixtures

  alias SacApiEx.Troubles.Trouble

  @create_attrs %{
    description: "some description",
    is_deleted: true,
    title: "some title",
    type: "some type"
  }
  @update_attrs %{
    description: "some updated description",
    is_deleted: false,
    title: "some updated title",
    type: "some updated type"
  }
  @invalid_attrs %{description: nil, is_deleted: nil, title: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all troubles", %{conn: conn} do
      conn = get(conn, Routes.trouble_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trouble" do
    test "renders trouble when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trouble_path(conn, :create), trouble: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trouble_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "is_deleted" => true,
               "title" => "some title",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trouble_path(conn, :create), trouble: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trouble" do
    setup [:create_trouble]

    test "renders trouble when data is valid", %{conn: conn, trouble: %Trouble{id: id} = trouble} do
      conn = put(conn, Routes.trouble_path(conn, :update, trouble), trouble: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trouble_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "is_deleted" => false,
               "title" => "some updated title",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trouble: trouble} do
      conn = put(conn, Routes.trouble_path(conn, :update, trouble), trouble: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trouble" do
    setup [:create_trouble]

    test "deletes chosen trouble", %{conn: conn, trouble: trouble} do
      conn = delete(conn, Routes.trouble_path(conn, :delete, trouble))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trouble_path(conn, :show, trouble))
      end
    end
  end

  defp create_trouble(_) do
    trouble = trouble_fixture()
    %{trouble: trouble}
  end
end
