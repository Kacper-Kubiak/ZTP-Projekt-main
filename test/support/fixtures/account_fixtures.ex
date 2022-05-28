defmodule AuthServer.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AuthServer.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        clientId: "some clientId",
        exp: 42,
        name: "some name",
        secret: "some secret",
        token: "some token"
      })
      |> AuthServer.Accounts.create_user()

    user
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        -: "some -",
        clientId: "some clientId",
        exp: 42,
        name: "some name",
        no-context: "some no-context",
        no-schema: "some no-schema",
        secret: "some secret",
        token: "some token"
      })
      |> AuthServer.Accounts.create_user()

    user
  end
end
