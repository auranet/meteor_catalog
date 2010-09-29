class License < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string
    open_source :boolean
    text_url    :string
    timestamps
  end

  has_many :plugins, :through => :plugin_licenses, :accessible => true
  has_many :plugin_licenses, :dependent => :destroy

  set_default_order "name"

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
