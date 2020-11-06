defmodule TimeManager.ScheduleTest do
  use TimeManager.DataCase

  alias TimeManager.Schedule

  describe "workingtimes" do
    alias TimeManager.Schedule.Workingtime

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00], user: 1}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01], user: 1}
    @invalid_attrs %{end: nil, start: nil, user: 1}

    def workingtime_fixture(attrs \\ %{}) do
      {:ok, workingtime} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_workingtime()

      workingtime
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Schedule.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Schedule.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      assert {:ok, %Workingtime{} = workingtime} = Schedule.create_workingtime(@valid_attrs)
      assert workingtime.end == ~N[2010-04-17 14:00:00]
      assert workingtime.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{} = workingtime} = Schedule.update_workingtime(workingtime, @update_attrs)
      assert workingtime.end == ~N[2011-05-18 15:01:01]
      assert workingtime.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Schedule.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Schedule.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Schedule.change_workingtime(workingtime)
    end
  end
end
