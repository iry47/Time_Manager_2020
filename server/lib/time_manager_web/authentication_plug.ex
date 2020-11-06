defmodule TimeManagerWeb.AuthenticationPlug do
  import Plug.Conn
  alias TimeManagerWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    case Token.decode(conn) do
      {:ok, claims} -> authorized(conn, claims)
      _ -> unauthorized(conn)
    end
  end

  def authorized(conn, claims) do
      assign(conn, :claims, claims)
  end

  def unauthorized(conn) do
      conn
     |> put_status(:unauthorized)
  end
end