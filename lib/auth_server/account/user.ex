defmodule AuthServer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :clientId, :string
    field :exp, :integer
    field :name, :string
    field :secret, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:clientId, :token, :name, :secret, :exp, :-, :"no-context", :-, :"no-schema"])
    |> validate_required([:clientId, :token, :name, :secret, :exp, :-, :"no-context", :-, :"no-schema"])
  end
end
