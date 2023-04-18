# frozen_string_literal: true

module ClientActions
  def self.build_client(params)
    Client.new(params.merge(external_id: SecureRandom.uuid))
  end
end
