defmodule AuthServerWeb.UserControllerTest do
  use AuthServerWeb.ConnCase

  import AuthServer.AccountFixtures

  alias AuthServer.Account.User

  @create_attrs %{
    -: "some -",
    clientId: "some clientId",
    exp: 42,
    name: "some name",
    no-context: "some no-context",
    no-schema: "some no-schema",
    secret: "some secret",
    token: "some token"
  }
  @update_attrs %{
    -: "some updated -",
    clientId: "some updated clientId",
    exp: 43,
    name: "some updated name",
    no-context: "some updated no-context",
    no-schema: "some updated no-schema",
    secret: "some updated secret",
    token: "some updated token"
  }
  @invalid_attrs %{-: nil, clientId: nil, exp: nil, name: nil, "no-context": nil, "no-schema": nil, secret: nil, token: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "-" => "some -",
               "clientId" => "some clientId",
               "exp" => 42,
               "name" => "some name",
               "no-context" => "some no-context",
               "no-schema" => "some no-schema",
               "secret" => "some secret",
               "token" => "some token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "-" => "some updated -",
               "clientId" => "some updated clientId",
               "exp" => 43,
               "name" => "some updated name",
               "no-context" => "some updated no-context",
               "no-schema" => "some updated no-schema",
               "secret" => "some updated secret",
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
