# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.uuid :external_id, null: false

      t.timestamps
    end
    add_index :clients, :external_id, unique: true
  end
end
