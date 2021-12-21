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

  describe "websites_troubles" do
    alias SacApiEx.Websites.WebsiteTrouble

    import SacApiEx.WebsitesFixtures

    @invalid_attrs %{"": nil, trouble_id: nil, website_id: nil}

    test "list_websites_troubles/0 returns all websites_troubles" do
      website_trouble = website_trouble_fixture()
      assert Websites.list_websites_troubles() == [website_trouble]
    end

    test "get_website_trouble!/1 returns the website_trouble with given id" do
      website_trouble = website_trouble_fixture()
      assert Websites.get_website_trouble!(website_trouble.id) == website_trouble
    end

    test "create_website_trouble/1 with valid data creates a website_trouble" do
      valid_attrs = %{"": "some ", trouble_id: "some trouble_id", website_id: "some website_id"}

      assert {:ok, %WebsiteTrouble{} = website_trouble} =
               Websites.create_website_trouble(valid_attrs)

      assert website_trouble.==("some ")
      assert website_trouble.trouble_id == "some trouble_id"
      assert website_trouble.website_id == "some website_id"
    end

    test "create_website_trouble/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Websites.create_website_trouble(@invalid_attrs)
    end

    test "update_website_trouble/2 with valid data updates the website_trouble" do
      website_trouble = website_trouble_fixture()

      update_attrs = %{
        "": "some updated ",
        trouble_id: "some updated trouble_id",
        website_id: "some updated website_id"
      }

      assert {:ok, %WebsiteTrouble{} = website_trouble} =
               Websites.update_website_trouble(website_trouble, update_attrs)

      assert website_trouble.==("some updated ")
      assert website_trouble.trouble_id == "some updated trouble_id"
      assert website_trouble.website_id == "some updated website_id"
    end

    test "update_website_trouble/2 with invalid data returns error changeset" do
      website_trouble = website_trouble_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Websites.update_website_trouble(website_trouble, @invalid_attrs)

      assert website_trouble == Websites.get_website_trouble!(website_trouble.id)
    end

    test "delete_website_trouble/1 deletes the website_trouble" do
      website_trouble = website_trouble_fixture()
      assert {:ok, %WebsiteTrouble{}} = Websites.delete_website_trouble(website_trouble)

      assert_raise Ecto.NoResultsError, fn ->
        Websites.get_website_trouble!(website_trouble.id)
      end
    end

    test "change_website_trouble/1 returns a website_trouble changeset" do
      website_trouble = website_trouble_fixture()
      assert %Ecto.Changeset{} = Websites.change_website_trouble(website_trouble)
    end
  end
end
