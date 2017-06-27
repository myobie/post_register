# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PostRegister.Repo.insert!(%PostRegister.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PostRegister.Blogs

Blogs.create_log(%{
                   name: "Test Log",
                   email_address: "c114c6cf8d66802c5e2f@cloudmailin.net",
                   from_email_addresses: ["naherald@microsoft.com", "me@nathanherald.com"]
                 })
