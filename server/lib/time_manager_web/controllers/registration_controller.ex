defmodule TimeManagerWeb.RegistrationController do
  use TimeManagerWeb, :controller

  alias TimeManager.Authentication
  alias TimeManager.Accounts

  def new(conn, _) do
      render(conn, :new, 
        changeset: Accounts.change_user(), 
        action: Routes.registration_path(conn, :create)
      )
  end



  def create(conn, user_params) do

    case Accounts.register(user_params) do
      {:ok, user} ->
        render(conn, "success.json",
            user: user
          )

      {:error, changeset} ->
        render(conn, "show.json", user: changeset)
    end
  end

end