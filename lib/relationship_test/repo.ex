defmodule RelationshipTest.Repo do
  use AshPostgres.Repo,
    otp_app: :relationship_test

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
