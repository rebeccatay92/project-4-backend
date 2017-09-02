class PhotoController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def create
    activity_id = params["activity_id"]
    request = params["data"]

    createdPhoto = Photo.create({
      activity_id: activity_id,
      url: request["url"]
    })

    render json: {
      response: "add a photo to activity",
      activity_id: activity_id,
      request: request,
      createdPhoto: createdPhoto
    }
  end

  def update
    photo_id = params["photo_id"]
    request = params["data"]
    thisPhoto = Photo.find(photo_id)

    updatedPhoto = thisPhoto.update({
      url: request["url"]
    })

    render json: {
      response: "update photo url",
      updatedPhoto: updatedPhoto
    }
  end

  def destroy
    photo_id = params["photo_id"]
    deletedPhoto = Photo.delete(photo_id)

    render json: {
      response: "remove this photo",
      deletedPhoto: deletedPhoto
    }
  end


end
