class ActivityController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def create
    render json: {
      response: "create new activity"
    }
  end

  def update
    render json: {
      response: "update the activity"
    }
  end

  def destroy
    render json: {
      response: "remove the activity"
    }
  end


end
