defmodule RelationshipTest.Relations do
  use Ash.Api

  resources do
    resource RelationshipTest.Relations.User
    resource RelationshipTest.Relations.Message
  end
end
