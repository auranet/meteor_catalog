class Book < ActiveRecord::Base
  belongs_to :genre
  has_and_belongs_to_many :authors

  def name
    title
  end
end
