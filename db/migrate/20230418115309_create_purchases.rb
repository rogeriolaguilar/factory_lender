# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.uuid :external_id, null: false
      t.decimal :amount, null: false
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
    add_index :purchases, :external_id, unique: true
  end
end
