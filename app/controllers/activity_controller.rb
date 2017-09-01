class ActivityController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  # fetch all activities and photos for that day
  def fetchDay
    itinerary_id = params["itinerary_id"]
    day = params["day"]

    activities = Activity.where({
      itinerary_id: itinerary_id,
      day: day
      })

    photos = activities.map { |e| Photo.where({
      activity_id: e.id
      })  }

    render json: {
      response: "when user clicks that day, show all activities for that day",
      params: params,
      itinerary_id: itinerary_id,
      day: day,
      activities: activities,
      photos: photos
    }
  end

  def create
    itinerary_id = params["itinerary_id"]
    request = params["data"]

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
  end

  def update
    activity_id = params["activity_id"]
    request = params["data"]
    activity = Activity.find(activity_id)

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
      request: request,
      updatedActivity: updatedActivity
    }
  end

  def destroy
    activity_id = params["activity_id"]
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
  end


end
