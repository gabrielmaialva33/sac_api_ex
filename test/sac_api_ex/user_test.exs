defmodule SacApiEx.UserTest do
  use SacApiEx.DataCase

  alias SacApiEx.User

  describe "roles" do
    alias SacApiEx.User.Role

    import SacApiEx.UserFixtures

    @invalid_attrs %{description: nil, name: nil, slug: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert User.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert User.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{description: "some description", name: "some name", slug: "some slug"}

      assert {:ok, %Role{} = role} = User.create_role(valid_attrs)
      assert role.description == "some description"
      assert role.name == "some name"
      assert role.slug == "some slug"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        slug: "some updated slug"
      }

      assert {:ok, %Role{} = role} = User.update_role(role, update_attrs)
      assert role.description == "some updated description"
      assert role.name == "some updated name"
      assert role.slug == "some updated slug"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_role(role, @invalid_attrs)
      assert role == User.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = User.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> User.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = User.change_role(role)
    end
  end
end
