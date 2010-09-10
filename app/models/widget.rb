class Widget < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name              :string
    short_description :text
    long_description  :text
    timestamps
  end

  belongs_to :plugin
  has_many :parameters

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
    true
  end

end
