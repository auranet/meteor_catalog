class Initial < ActiveRecord::Migration
  def self.up
    create_table :plugins do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :parameters do |t|
      t.string   :name
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :widget_id
    end
    add_index :parameters, [:widget_id]

    create_table :widgets do |t|
      t.string   :name
      t.text     :short_description
      t.text     :long_description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :plugin_id
    end
    add_index :widgets, [:plugin_id]

    create_table :licenses do |t|
      t.string   :name
      t.boolean  :open_source
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :plugin_id
    end
    add_index :licenses, [:plugin_id]

    create_table :valid_values do |t|
      t.string   :value
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :parameter_id
    end
    add_index :valid_values, [:parameter_id]

    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    add_index :users, [:state]
  end

  def self.down
    drop_table :plugins
    drop_table :parameters
    drop_table :widgets
    drop_table :licenses
    drop_table :valid_values
    drop_table :users
  end
end
