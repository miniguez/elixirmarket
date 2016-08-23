defmodule Market.UserController do
  use Market.Web, :controller

  alias Market.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :add_breadcrumb, name: Gettext.gettext(Market.Gettext, "home"), url: '/'

  def index(conn, _params) do
    breadcrumb= [[name: Gettext.gettext(Market.Gettext, "users")]]

    users = Repo.all(User)
    render(conn, "index.html", users: users, breadcrumb: breadcrumb)
  end

  def new(conn, _params) do
    breadcrumb= [
      [name: Gettext.gettext(Market.Gettext, "users"), url: "/users"],
      [name: Gettext.gettext(Market.Gettext, "new user")]
    ]
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset, breadcrumb: breadcrumb)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
