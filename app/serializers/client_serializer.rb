class ClientSerializer < ActiveModel::Serializer
  attributes :external_id, :name, :created_at, :updated_at
end
