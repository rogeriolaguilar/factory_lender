class Client < ApplicationRecord
   validates :name, :external_id, presence: true
end
