# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.uuid :external_id, null: false
      t.decimal :amount, null: false
      t.datetime :due_date, null: false
      t.string :status, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
    add_index :invoices, :external_id, unique: true
  end
end
