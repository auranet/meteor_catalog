class AddGenreIdToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :genre_id, :integer
  end

  def self.down
    remove_column :books, :genre_id
  end
end
