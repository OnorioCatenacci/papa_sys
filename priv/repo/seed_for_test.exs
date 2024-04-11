# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seed_for_test.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PapaSys.Repo.insert!(%PapaSys.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Insert test users
PapaSys.Repo.insert!(%PapaSys.Client.User{
  email_address: "nowhere@nomail.com",
  first_name: "John",
  last_name: "Doe",
  role: "pal",
  account_minutes: 0
})

PapaSys.Repo.insert!(%PapaSys.Client.User{
  email_address: "nowhere2@nomail.com",
  first_name: "Jane",
  last_name: "Doe",
  role: "pal",
  account_minutes: 0
})

PapaSys.Repo.insert!(%PapaSys.Client.User{
  email_address: "somewhere@somemail.com",
  first_name: "Jake",
  last_name: "Doe",
  role: "member",
  account_minutes: 180
})

PapaSys.Repo.insert!(%PapaSys.Client.User{
  email_address: "somewhereelse@nomail.com",
  first_name: "Jennifer",
  last_name: "Doe",
  role: "both",
  account_minutes: 60
})

# We also want to seed visit requests.  
# I realize this probably seems a bit odd but this way we can be assured we get the correct key values for the various user ids.
import Ecto.Query

defmodule Lookup do
  def get_id_for_user(user_first_name, user_last_name) do
    from(u in PapaSys.Client.User,
      where: u.first_name == ^user_first_name,
      where: u.last_name == ^user_last_name,
      select: u.id
    )
    |> PapaSys.Repo.one()
  end
end

# Insert visit requests
jennifer_id = Lookup.get_id_for_user("Jennifer", "Doe")
jake_id = Lookup.get_id_for_user("Jake", "Doe")

PapaSys.Repo.insert!(%PapaSys.Service.Visit{
  user_id: jennifer_id,
  visit_date: ~D[2025-01-01],
  visit_duration: 15,
})


PapaSys.Repo.insert!(%PapaSys.Service.Visit{
  user_id: jake_id,
  visit_date: ~D[2025-01-02],
  visit_duration: 45
})


PapaSys.Repo.insert!(%PapaSys.Service.Visit{
  user_id: jennifer_id,
  visit_date: ~D[2025-01-07],
  visit_duration: 120
})
