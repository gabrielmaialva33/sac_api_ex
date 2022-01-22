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

  describe "reports" do
    alias SacApiEx.Troubles.Report

    import SacApiEx.TroublesFixtures

    @invalid_attrs %{is_reported: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Troubles.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Troubles.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{is_reported: true}

      assert {:ok, %Report{} = report} = Troubles.create_report(valid_attrs)
      assert report.is_reported == true
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Troubles.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{is_reported: false}

      assert {:ok, %Report{} = report} = Troubles.update_report(report, update_attrs)
      assert report.is_reported == false
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Troubles.update_report(report, @invalid_attrs)
      assert report == Troubles.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Troubles.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Troubles.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Troubles.change_report(report)
    end
  end
end
