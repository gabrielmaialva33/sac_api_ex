defmodule SacApiEx.TroublesTest do
  use SacApiEx.DataCase

  alias SacApiEx.Troubles

  describe "troubles" do
    alias SacApiEx.Troubles.Trouble

    import SacApiEx.TroublesFixtures

    @invalid_attrs %{description: nil, is_deleted: nil, title: nil, type: nil}

    test "list_troubles/0 returns all troubles" do
      trouble = trouble_fixture()
      assert Troubles.list_troubles() == [trouble]
    end

    test "get_trouble!/1 returns the trouble with given id" do
      trouble = trouble_fixture()
      assert Troubles.get_trouble!(trouble.id) == trouble
    end

    test "create_trouble/1 with valid data creates a trouble" do
      valid_attrs = %{
        description: "some description",
        is_deleted: true,
        title: "some title",
        type: "some type"
      }

      assert {:ok, %Trouble{} = trouble} = Troubles.create_trouble(valid_attrs)
      assert trouble.description == "some description"
      assert trouble.is_deleted == true
      assert trouble.title == "some title"
      assert trouble.type == "some type"
    end

    test "create_trouble/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Troubles.create_trouble(@invalid_attrs)
    end

    test "update_trouble/2 with valid data updates the trouble" do
      trouble = trouble_fixture()

      update_attrs = %{
        description: "some updated description",
        is_deleted: false,
        title: "some updated title",
        type: "some updated type"
      }

      assert {:ok, %Trouble{} = trouble} = Troubles.update_trouble(trouble, update_attrs)
      assert trouble.description == "some updated description"
      assert trouble.is_deleted == false
      assert trouble.title == "some updated title"
      assert trouble.type == "some updated type"
    end

    test "update_trouble/2 with invalid data returns error changeset" do
      trouble = trouble_fixture()
      assert {:error, %Ecto.Changeset{}} = Troubles.update_trouble(trouble, @invalid_attrs)
      assert trouble == Troubles.get_trouble!(trouble.id)
    end

    test "delete_trouble/1 deletes the trouble" do
      trouble = trouble_fixture()
      assert {:ok, %Trouble{}} = Troubles.delete_trouble(trouble)
      assert_raise Ecto.NoResultsError, fn -> Troubles.get_trouble!(trouble.id) end
    end

    test "change_trouble/1 returns a trouble changeset" do
      trouble = trouble_fixture()
      assert %Ecto.Changeset{} = Troubles.change_trouble(trouble)
    end
  end
end
