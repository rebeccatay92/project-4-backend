class ActivityController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  # fetch all activities and photos for that day
  def fetchDay
    user_id = current_resource_owner["id"]

    itinerary_id = params["itinerary_id"]
    day = params["day"]

    itinerary = Itinerary.find(itinerary_id)

    if user_id == itinerary["user_id"]
      activities = Activity.where({
        itinerary_id: itinerary_id,
        day: day
        })

      photos = activities.map { |e| Photo.where({
        activity_id: e.id
        })  }

      render json: {
        response: "when user clicks that day, show all activities for that day",
        status: 200,
        itinerary_id: itinerary_id,
        day: day,
        activities: activities,
        photos: photos
      }
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end
  end

  def create
    user_id = current_resource_owner["id"]
    itinerary_id = params["itinerary_id"]
    request = params["data"]

    itinerary = Itinerary.find(itinerary_id)

    if user_id == itinerary["user_id"]
      createdActivity = Activity.create({
        itinerary_id: itinerary_id,
        day: request["day"],
        place: request["place"],
        latitude: request["latitude"],
        longitude: request["longitude"],
        blurb: request["blurb"],
        content: request["content"]
        })

      render json: {
        response: "create new activity",
        itinerary_id: itinerary_id,
        request: request,
        createdActivity: createdActivity
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
    activity_id = params["activity_id"]

    activity = Activity.find(activity_id)
    itinerary = activity.itinerary

    if user_id == itinerary["user_id"]
      request = params["data"]

      updatedActivity = activity.update({
        day: request["day"],
        place: request["place"],
        latitude: request["latitude"],
        longitude: request["longitude"],
        blurb: request["blurb"],
        content: request["content"]
        })

      render json: {
        response: "update the activity",
        updatedActivity: updatedActivity
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
    activity_id = params["activity_id"]

    activity = Activity.find(activity_id)
    itinerary = activity.itinerary

    if user_id == itinerary["user_id"]
      associatedPhotos = Photo.where({activity_id: activity_id})
      deletedPhotos = associatedPhotos.each do |e|
        id = e["id"]
        Photo.delete(id)
      end
      deletedActivity = Activity.delete(activity_id)

      render json: {
        response: "remove the activity and associated photos",
        activity_id: activity_id,
        deletedActivity: deletedActivity,
        deletedPhotos: deletedPhotos
      }
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end

  end

end
