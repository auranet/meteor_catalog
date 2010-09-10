class License < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    open_source :boolean
    timestamps
  end

  belongs_to :plugin

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
