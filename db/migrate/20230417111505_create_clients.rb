# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.uuid :external_id

      t.timestamps
    end
    add_index :clients, :external_id, unique: true
  end
end
