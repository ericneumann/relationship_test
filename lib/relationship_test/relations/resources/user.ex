defmodule RelationshipTest.Relations.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo RelationshipTest.Repo
  end

  code_interface do
    define_for RelationshipTest.Relations
    define :create, action: :create
    define :read_all, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
  end

  actions do
    defaults [:read, :create, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false

      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :email, :ci_string do
      allow_nil? false
    end
  end

  relationships do
    has_many :message, RelationshipTest.Relations.Message
  end
end
