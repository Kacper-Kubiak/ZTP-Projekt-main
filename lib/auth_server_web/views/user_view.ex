defmodule AuthServerWeb.UserView do
  use AuthServerWeb, :view
  alias AuthServerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      clientId: user.clientId,
      token: user.token,
      name: user.name,
      secret: user.secret,
      exp: user.exp,
    }
  end
end
