# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TimeManager.Repo
alias TimeManager.Accounts.User
alias TimeManager.Schedule.Workingtime
alias TimeManager.Timer.Clock
alias TimeManager.Accounts.Widget
alias TimeManager.Accounts.WidgetUser
alias TimeManager.Accounts.Team
alias TimeManager.Accounts.TeamUser

Repo.insert! %User{
    admin: false,
    email: "manager@me.com",
    gridster: false,
    active_hash: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe1XbWASACYodW.VXrFvTG9LDquemGXP.",
    manager: true,
    lastname: "manager",
    salt: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe",
    firstname: "manager"
}
Repo.insert! %User{
    admin: true,
    email: "admin@me.com",
    gridster: false,
    active_hash: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe1XbWASACYodW.VXrFvTG9LDquemGXP.",
    manager: false,
    lastname: "admin",
    salt: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe",
    firstname: "admin"
}
Repo.insert! %User{
    admin: false,
    email: "employee@me.com",
    gridster: false,
    active_hash: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe1XbWASACYodW.VXrFvTG9LDquemGXP.",
    manager: true,
    lastname: "employee",
    salt: "$2b$12$x19JHoW5pF4Rcj8cNb/uqe",
    firstname: "employee"
}
Repo.insert! %Workingtime{
    start: ~N[2020-10-15 10:00:00],
    end: ~N[2020-10-15 12:00:00],
    user: 1
}
Repo.insert! %Workingtime{
    start: ~N[2020-10-16 10:00:00],
    end: ~N[2020-10-16 14:00:00],
    user: 1
}
Repo.insert! %Workingtime{
    start: ~N[2020-10-16 10:00:00],
    end: ~N[2020-10-16 14:00:00],
    user: 2
}
Repo.insert! %Clock{
    status: false,
    time: ~N[2020-10-17 14:00:00],
    user: 1
}
Repo.insert! %Clock{
    status: true,
    time: ~N[2020-10-17 14:00:00],
    user: 2
}
Repo.insert! %Widget{
    name: "widget1",
    description: "description of a widget"
}
Repo.insert! %Widget{
    name: "widget2",
    description: "description of a widget"
}
Repo.insert! %WidgetUser{
    widget: 1,
    user: 1,
    param_one: "param1"
}
Repo.insert! %WidgetUser{
    widget: 1,
    user: 2
}
Repo.insert! %Team{
    name: "team1"
}
Repo.insert! %Team{
    name: "team2"
}
Repo.insert! %TeamUser{
    team: 1,
    user: 1,
}
Repo.insert! %TeamUser{
    team: 2,
    user: 3,
}
Repo.insert! %TeamUser{
    team: 1,
    user: 2,
}