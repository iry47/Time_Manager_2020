defmodule TimeManagerWeb.SessionController do
  use TimeManagerWeb, :controller
  alias TimeManager.Authentication
  alias TimeManagerWeb.Token

    def new(conn, _) do
        render(conn, :new, changeset: conn, action: "/signin")
    end
    def create(conn, params) do
      case Authentication.signin(conn, params) do
        {:ok, user} ->
          
          user_claim = %{
            "id" => user.id,
            "email" => user.email,
            "hash" => user.hash,
            "admin" => user.admin,
            "manager" => user.manager,
            "gridster" => user.gridster,
            "salt" => user.salt,
            "firstname" => user.firstname,
            "lastname" => user.lastname
          }
          token = Token.generate_and_sign!(user_claim, Token.signer)
        render(conn, "success.json",
            user: user,
            token: token
          )
        
        {:error, changeset} ->
          render(conn, "show.json",
            user: changeset
          )
      end
    end
end