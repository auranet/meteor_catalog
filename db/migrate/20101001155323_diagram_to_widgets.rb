class DiagramToWidgets < ActiveRecord::Migration
  def self.up
    add_column :widgets, :diagram_file_name, :string
    add_column :widgets, :diagram_content_type, :string
    add_column :widgets, :diagram_file_size, :integer
    add_column :widgets, :diagram_updated_at, :datetime
  end

  def self.down
    remove_column :widgets, :diagram_file_name
    remove_column :widgets, :diagram_content_type
    remove_column :widgets, :diagram_file_size
    remove_column :widgets, :diagram_updated_at
  end
end
