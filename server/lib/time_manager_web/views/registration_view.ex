defmodule TimeManagerWeb.RegistrationView do
  use TimeManagerWeb, :view

  def render("success.json", %{user: _user}) do
    %{
      status: :ok,
      message: """
        Welcome ! 
      """
    }
  end

  def render("show.json", %{user: user}) do
    %{firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      active_hash: user.active_hash,
      salt: user.salt,
      admin: user.admin,
      manager: user.manager,
      gridster: user.gridster}
  end
  
end