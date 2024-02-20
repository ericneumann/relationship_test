defmodule RelationshipTest.Relations.RelationshipTest do
  use RelationshipTest.DataCase, async: true

  alias RelationshipTest.Relations
  alias RelationshipTest.Relations.Message

  test "build user and message and retrieve with get_by_id" do
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
    assert msg.user.name == user.name
  end

  test "build user and message and retrieve with read_all_with_user_info" do
    user = build_user()
    content = Faker.Lorem.words(10) |> Enum.join(" ")

    Message
    |> Ash.Changeset.for_create(
      :create,
      %{
        content: content,
        user_id: user.id
      }
    )
    |> Relations.create()

    {:ok, messages} = Message.read_all_with_user_info()
    msg = messages |> hd()

    assert msg.user.name == user.name
  end

  test "build user and message and retrieve with read_all_with_user_info!" do
    user = build_user()
    content = Faker.Lorem.words(10) |> Enum.join(" ")

    Message
    |> Ash.Changeset.for_create(
      :create,
      %{
        content: content,
        user_id: user.id
      }
    )
    |> Relations.create()

    msg =
      Message.read_all_with_user_info!()
      |> hd()

    assert msg.user.name == user.name
  end

  test "build user and message and retrieve with read_all" do
    user = build_user()
    content = Faker.Lorem.words(10) |> Enum.join(" ")

    Message
    |> Ash.Changeset.for_create(
      :create,
      %{
        content: content,
        user_id: user.id
      }
    )
    |> Relations.create()

    {:ok, messages} = Message.read_all()
    msg = messages |> hd()

    assert msg.user.name == user.name
  end

  test "build user and message and retrieve with read_all!" do
    user = build_user()
    content = Faker.Lorem.words(10) |> Enum.join(" ")

    Message
    |> Ash.Changeset.for_create(
      :create,
      %{
        content: content,
        user_id: user.id
      }
    )
    |> Relations.create()

    msg =
      Message.read_all!()
      |> hd()

    assert msg.user.name == user.name
  end
end
