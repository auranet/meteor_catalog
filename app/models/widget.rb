class Widget < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name              :string
    short_description :text
    long_description  :markdown
    published         :boolean
    example           :raw_html
    major_revision    :integer, :default => 0
    minor_revision    :integer, :default => 0
    timestamps
  end

  has_attached_file :diagram

  belongs_to :plugin
  has_many :parameters

  set_default_order "name"

  set_search_columns :name, :short_description, :long_description

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    acting_user.administrator? or published?
  end

end
