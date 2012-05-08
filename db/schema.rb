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

ActiveRecord::Schema.define(:version => 20120508183212) do

  create_table "appointments", :force => true do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "customer_id"
    t.string   "appointment_type"
    t.string   "status"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  create_table "charges", :force => true do |t|
    t.datetime "date"
    t.text     "description"
    t.float    "quantity"
    t.float    "price"
    t.integer  "quote_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "customer_extensions", :force => true do |t|
    t.integer  "customer_id"
    t.string   "age"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "education"
    t.string   "household_income"
    t.string   "home_owner_status"
    t.string   "home_market_value"
    t.string   "home_property_value"
    t.string   "length_of_residence"
    t.string   "zip"
    t.string   "occupation"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "dealers", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "sample_name",       :default => "Sample"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "quotes", :force => true do |t|
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.string   "status"
  end

  create_table "sample_checkouts", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "sample_id"
    t.datetime "checkout_time"
    t.datetime "checkin_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "samples", :force => true do |t|
    t.string   "dealer_sample_id"
    t.string   "name"
    t.string   "sample_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "store_id"
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "dealer_id"
    t.string   "phone"
    t.string   "website"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "dealer_id"
    t.datetime "created_at",                                                                                                :null => false
    t.datetime "updated_at",                                                                                                :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "active",                            :default => true
    t.string   "role"
    t.string   "phone"
    t.text     "message",                           :default => "Please contact me at any time if you have any questions."
    t.boolean  "subscribes_to_customer_extensions", :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "invitation_id"
    t.string   "title"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
