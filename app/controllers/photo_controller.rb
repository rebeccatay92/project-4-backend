class PhotoController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def create

    render json: {
      response: "add a photo to activity"
    }
  end

  def update

    render json: {
      response: "update photo url"
    }
  end

  def destroy
    render json: {
      response: "remove this photo"
    }
  end


end
