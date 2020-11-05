defmodule TimeManagerWeb.SessionView do
    use TimeManagerWeb, :view

    alias TimeManagerWeb.SessionView

    def render("success.json", %{user: user, token: token}) do
        %{
            user: %{id: user.id,
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email,
                active_hash: user.active_hash,
                salt: user.salt,
                admin: user.admin,
                manager: user.manager,
                gridster: user.gridster
            },
            token: %{
                token: token
            }
        }
    end

    def render("show.json", %{user: user}) do
        %{email: user.email,
        active_hash: user.active_hash
        }
    end

end