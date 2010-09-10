class LicensesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => :index
  auto_actions_for :plugin, [:new, :create]

end
