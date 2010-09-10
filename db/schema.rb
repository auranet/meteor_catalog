# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100910175229) do

  create_table "licenses", :force => true do |t|
    t.string   "name"
    t.boolean  "open_source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plugin_id"
  end

  add_index "licenses", ["plugin_id"], :name => "index_licenses_on_plugin_id"

  create_table "parameters", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "widget_id"
  end

  add_index "parameters", ["widget_id"], :name => "index_parameters_on_widget_id"

  create_table "plugins", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

  create_table "valid_values", :force => true do |t|
    t.string   "value"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parameter_id"
  end

  add_index "valid_values", ["parameter_id"], :name => "index_valid_values_on_parameter_id"

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.text     "short_description"
    t.text     "long_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plugin_id"
  end

  add_index "widgets", ["plugin_id"], :name => "index_widgets_on_plugin_id"

end
