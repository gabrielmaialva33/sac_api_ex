defmodule SacApiEx.WebsitesTest do
  use SacApiEx.DataCase

  alias SacApiEx.Websites

  describe "websites" do
    alias SacApiEx.Websites.Website

    import SacApiEx.WebsitesFixtures

    @invalid_attrs %{description: nil, is_deleted: nil, title: nil, url: nil}

    test "list_websites/0 returns all websites" do
      website = website_fixture()
      assert Websites.list_websites() == [website]
    end

    test "get_website!/1 returns the website with given id" do
      website = website_fixture()
      assert Websites.get_website!(website.id) == website
    end

    test "create_website/1 with valid data creates a website" do
      valid_attrs = %{
        description: "some description",
        is_deleted: true,
        title: "some title",
        url: "some url"
      }

      assert {:ok, %Website{} = website} = Websites.create_website(valid_attrs)
      assert website.description == "some description"
      assert website.is_deleted == true
      assert website.title == "some title"
      assert website.url == "some url"
    end

    test "create_website/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Websites.create_website(@invalid_attrs)
    end

    test "update_website/2 with valid data updates the website" do
      website = website_fixture()

      update_attrs = %{
        description: "some updated description",
        is_deleted: false,
        title: "some updated title",
        url: "some updated url"
      }

      assert {:ok, %Website{} = website} = Websites.update_website(website, update_attrs)
      assert website.description == "some updated description"
      assert website.is_deleted == false
      assert website.title == "some updated title"
      assert website.url == "some updated url"
    end

    test "update_website/2 with invalid data returns error changeset" do
      website = website_fixture()
      assert {:error, %Ecto.Changeset{}} = Websites.update_website(website, @invalid_attrs)
      assert website == Websites.get_website!(website.id)
    end

    test "delete_website/1 deletes the website" do
      website = website_fixture()
      assert {:ok, %Website{}} = Websites.delete_website(website)
      assert_raise Ecto.NoResultsError, fn -> Websites.get_website!(website.id) end
    end

    test "change_website/1 returns a website changeset" do
      website = website_fixture()
      assert %Ecto.Changeset{} = Websites.change_website(website)
    end
  end
end
