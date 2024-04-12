defmodule PapaSysWeb.VisitControllerTest do
  use PapaSysWeb.ConnCase

  import PapaSys.ServiceFixtures

  alias PapaSys.Service.Visit

  @expected_create_visit_date Date.to_string(Date.utc_today())
  @expected_update_visit_date Date.to_string(Date.add(Date.utc_today(), 1))

  @create_attrs %{
    user_id: 1,
    visit_date: @expected_create_visit_date,
    visit_duration: 42
  }
  @update_attrs %{
    user_id: 1,
    visit_date: @expected_update_visit_date,
    visit_duration: 43
  }
  @invalid_attrs %{visit_date: nil, visit_duration: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all visits", %{conn: conn} do
      conn = get(conn, ~p"/api/visits")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create visit" do
    test "renders visit when data is valid", %{conn: conn} do
      # Need to insert a user so the foreign key works correctly
      PapaSys.ClientFixtures.member_fixture()
      conn = post(conn, ~p"/api/visits", visit: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/visits/#{id}")

      assert %{
               "id" => ^id,
               "visit_date" => @expected_create_visit_date,
               "visit_duration" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/visits", visit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update visit" do
    setup [:create_visit]

    test "renders visit when data is valid", %{conn: conn, visit: %Visit{id: id} = visit} do
      conn = put(conn, ~p"/api/visits/#{visit}", visit: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/visits/#{id}")

      assert %{
               "id" => ^id,
               "visit_date" => @expected_update_visit_date,
               "visit_duration" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, visit: visit} do
      conn = put(conn, ~p"/api/visits/#{visit}", visit: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete visit" do
    setup [:create_visit]

    test "deletes chosen visit", %{conn: conn, visit: visit} do
      conn = delete(conn, ~p"/api/visits/#{visit}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/visits/#{visit}")
      end
    end
  end

  defp create_visit(_) do
    user = PapaSys.ClientFixtures.member_fixture()
    visit = visit_fixture(user)
    %{visit: visit}
  end
end
