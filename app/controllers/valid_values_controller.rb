class ValidValuesController < ApplicationController

  hobo_model_controller

  auto_actions :create, :destroy
  auto_actions_for :parameter, [:create]

end
