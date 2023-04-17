class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.uuid :external_id
      t.decimal :amount
      t.datetime :due_date
      t.string :status
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
    add_index :invoices, :external_id, unique: true
  end
end
