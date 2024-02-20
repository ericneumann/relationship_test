defmodule RelationshipTest.Relations.Message do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "messages"
    repo RelationshipTest.Repo
  end

  code_interface do
    define_for RelationshipTest.Relations
    define :create, action: :create
    define :read_all, action: :read
    define :read_all_with_user_info, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
  end

  actions do
    defaults [:create, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false

      get? true
      filter expr(id == ^arg(:id))
      # prepare build(load: [:user])
    end

    read :read do
      primary? true
      # prepare build(load: [:user])
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :content, :string do
      allow_nil? false
    end

    # attribute :user_id, :uuid, allow_nil?: false
  end

  relationships do
    belongs_to :user, RelationshipTest.Relations.User do
      attribute_writable? true
      allow_nil? false
    end
  end
end
