class LicensesNowManyToMany < ActiveRecord::Migration
  def self.up
    create_table :plugin_licenses do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :plugin_id
      t.integer  :license_id
    end
    add_index :plugin_licenses, [:plugin_id]
    add_index :plugin_licenses, [:license_id]

    remove_column :licenses, :plugin_id

    remove_index :licenses, :name => :index_licenses_on_plugin_id rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :licenses, :plugin_id, :integer

    drop_table :plugin_licenses

    add_index :licenses, [:plugin_id]
  end
end
