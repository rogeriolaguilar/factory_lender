# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_418_115_309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'clients', force: :cascade do |t|
    t.string 'name', null: false
    t.uuid 'external_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['external_id'], name: 'index_clients_on_external_id', unique: true
  end

  create_table 'invoices', force: :cascade do |t|
    t.uuid 'external_id', null: false
    t.decimal 'amount', null: false
    t.datetime 'due_date', null: false
    t.string 'status', null: false
    t.bigint 'client_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['client_id'], name: 'index_invoices_on_client_id'
    t.index ['external_id'], name: 'index_invoices_on_external_id', unique: true
  end

  create_table 'purchases', force: :cascade do |t|
    t.uuid 'external_id', null: false
    t.decimal 'amount', null: false
    t.bigint 'invoice_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['external_id'], name: 'index_purchases_on_external_id', unique: true
    t.index ['invoice_id'], name: 'index_purchases_on_invoice_id'
  end

  add_foreign_key 'invoices', 'clients'
  add_foreign_key 'purchases', 'invoices'
end
