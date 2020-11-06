defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto

  alias TimeManager.Accounts.User

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :gridster, :boolean, default: false
    field :active_hash, :string
    field :manager, :boolean, default: false
    field :salt, :string
    field :firstname, :string, default: ""
    field :lastname, :string, default: ""
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :active_hash, :salt, :admin, :manager, :gridster])
    |> validate_required([:email, :active_hash, :salt, :admin, :manager, :gridster])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(%User{} = user, attrs) do
    salt = Bcrypt.gen_salt()
    active_hash = Bcrypt.Base.hash_password(attrs["password"], salt)
    user
    |> cast(attrs, [:firstname, :lastname, :email, :active_hash, :salt, :admin, :manager, :gridster])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> Ecto.Changeset.cast(%{salt: salt}, [:salt])
    |> Ecto.Changeset.put_change(:active_hash, active_hash)
    |> cast(%{active_hash: active_hash}, [:active_hash])
  end

end
