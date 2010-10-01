class WidgetsController < ApplicationController

  hobo_model_controller

  auto_actions :all
  auto_actions_for :plugin, [:create]
  show_action :example

end
