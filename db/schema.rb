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

ActiveRecord::Schema.define(:version => 20120703124233) do

  create_table "app_requests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "app_name"
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

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.string   "facebook"
    t.string   "sample_name",             :default => "Sample"
    t.string   "logo"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "description_location"
    t.string   "description_type"
    t.string   "name_location"
    t.string   "name_type"
    t.string   "price_location"
    t.string   "price_type"
    t.string   "product_number_location"
    t.string   "product_number_type"
    t.boolean  "scraping_configured",     :default => false
    t.boolean  "currently_scraping",      :default => false
    t.datetime "last_scrape"
    t.integer  "run_every_x_days",        :default => 7
    t.string   "image_location"
    t.string   "image_type"
    t.boolean  "wants_website_scraped"
  end

  create_table "company_users", :force => true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
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
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.boolean  "marketable", :default => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "recipient_id"
    t.string   "status",          :default => "sent"
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

  create_table "sample_checkout_sets", :force => true do |t|
    t.integer  "notifications_received"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "customer_id"
    t.integer  "user_id"
  end

  create_table "sample_checkouts", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "sample_id"
    t.datetime "checkout_time"
    t.datetime "checkin_time"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "user_id"
    t.integer  "notifications_received", :default => 0
    t.integer  "sample_checkout_set_id"
  end

  create_table "samples", :force => true do |t|
    t.string   "dealer_sample_id"
    t.string   "name"
    t.string   "sample_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "company_id"
    t.text     "description"
    t.string   "price"
    t.string   "url"
    t.string   "creator",          :default => "User"
    t.string   "image_url"
  end

  create_table "sent_emails", :force => true do |t|
    t.integer  "customer_id"
    t.string   "notification_type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "notification_type_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                                                                                :null => false
    t.datetime "updated_at",                                                                                                :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "role"
    t.string   "phone"
    t.text     "message",                           :default => "Please contact me at any time if you have any questions."
    t.boolean  "subscribes_to_customer_extensions", :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "title"
    t.boolean  "display_tutorial",                  :default => true
    t.integer  "reminder_interval_days",            :default => 7
    t.boolean  "receives_nightly_digest",           :default => true
    t.boolean  "receive_low_activity_mailer",       :default => true
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "last_sign_in"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
