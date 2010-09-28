class ParametersController < ApplicationController

  hobo_model_controller

  auto_actions :create, :destroy, :update
  auto_actions_for :widget, [:create]

end
