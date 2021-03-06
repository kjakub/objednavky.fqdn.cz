# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121006191929) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "surname"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "customers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "name"
    t.string   "surname"
    t.string   "company_name"
    t.string   "phone"
    t.boolean  "delivery_same"
    t.string   "billing_street"
    t.string   "billing_zip"
    t.string   "billing_city"
    t.string   "billing_country"
    t.string   "delivery_street"
    t.string   "delivery_zip"
    t.string   "delivery_city"
    t.string   "delivery_country"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "customers", ["authentication_token"], :name => "index_customers_on_authentication_token", :unique => true
  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["reset_password_token"], :name => "index_customers_on_reset_password_token", :unique => true

  create_table "orders", :force => true do |t|
    t.text     "comment"
    t.string   "delivery_mode"
    t.string   "tracking_number"
    t.string   "enclosure_file_name"
    t.string   "enclosure_content_type"
    t.integer  "enclosure_file_size"
    t.datetime "enclosure_updated_at"
    t.integer  "admin_id"
    t.integer  "customer_id"
    t.integer  "admin_approver_id"
    t.boolean  "approved",               :default => false
    t.boolean  "sent",                   :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "orders", ["admin_id"], :name => "index_orders_on_admin_id"
  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"

end
