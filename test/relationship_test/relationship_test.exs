defmodule RelationshipTest.Relations.RelationshipTest do
  use RelationshipTest.DataCase, async: true

  alias RelationshipTest.Relations
  alias RelationshipTest.Relations.Message

  test "build user and message and retrieve relation" do
    user = build_user()
    content = Faker.Lorem.words(10) |> Enum.join(" ")

    {:ok, message} =
      Message
      |> Ash.Changeset.for_create(
        :create,
        %{
          content: content,
          user_id: user.id
        }
      )
      |> Relations.create()

    msg = Message.get_by_id!(message.id)
    IO.puts(user.name)
    IO.puts(user.id)
    IO.puts(message.id)
    IO.puts(message.content)
    IO.puts(message.user_id)
    assert msg.user.name == user.name
  end
end
