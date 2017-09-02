class PhotoController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def create
    user_id = current_resource_owner["id"]

    activity_id = params["activity_id"]
    activity = Activity.find(activity_id)
    itinerary = activity.itinerary

    if user_id == itinerary["user_id"]
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
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end

  end

  def update
    user_id = current_resource_owner["id"]
    photo_id = params["photo_id"]
    photo = Photo.find(photo_id)
    activity = photo.activity
    itinerary = activity.itinerary

    if user_id == itinerary["user_id"]
      request = params["data"]
      thisPhoto = Photo.find(photo_id)

      updatedPhoto = thisPhoto.update({
        url: request["url"]
        })

        render json: {
          response: "update photo url",
          updatedPhoto: updatedPhoto
        }
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end
  end

  def destroy
    user_id = current_resource_owner["id"]
    photo_id = params["photo_id"]
    photo = Photo.find(photo_id)
    activity = photo.activity
    itinerary = activity.itinerary

    if user_id == itinerary["user_id"]
      deletedPhoto = Photo.delete(photo_id)

      render json: {
        response: "remove this photo",
        deletedPhoto: deletedPhoto
      }
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end
  end

end
