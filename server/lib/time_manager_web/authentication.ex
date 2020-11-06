defmodule TimeManager.Authentication do
  import Ecto.Query

  alias TimeManager.Accounts
  alias TimeManager.Accounts.User

#   @moduledoc """
#   Authentication of user
      # - signin
      # - check password
#   """

  def signin(conn, params) do
    query = Ecto.Query.from(u in User, where: u.email == ^params["email"])

    TimeManager.Repo.one(query)
    |> check_password(params["password"])

  end

  defp check_password(nil, _), do: {:error, "Incorrect email or password"}

  defp check_password(user, password) do
    case Bcrypt.Base.hash_password(password, user.salt) == user.hash do
      true -> {:ok, user}
      false -> {:error, "Incorrect password"}
    end
  end


 end