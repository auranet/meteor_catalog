class MoreFieldsAcrossTheBoard < ActiveRecord::Migration
  def self.up
    add_column :plugins, :repository_url, :string

    add_column :widgets, :published, :boolean
    add_column :widgets, :example, :text
    add_column :widgets, :major_revision, :integer, :default => 0
    add_column :widgets, :minor_revision, :integer, :default => 0

    add_column :licenses, :text_url, :string
  end

  def self.down
    remove_column :plugins, :repository_url

    remove_column :widgets, :published
    remove_column :widgets, :example
    remove_column :widgets, :major_revision
    remove_column :widgets, :minor_revision

    remove_column :licenses, :text_url
  end
end
