class ItineraryController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def index
    user_id = current_resource_owner["id"]
    current_user_name = current_resource_owner["name"]
    allItineraries = Itinerary.where({user_id: user_id})

    render json: {
      response: "show all itineraries by logged in user",
      user_id: user_id,
      allItineraries: allItineraries
    }
  end

  def show
    user_id = current_resource_owner["id"]
    current_user_name = current_resource_owner["name"]
    itinerary_id = params["id"]
    # need extra user_id condition in find so ppl cannot access itinerary of other user by modifying url
    itinerary = Itinerary.find(itinerary_id)

    activities = itinerary.activities
    photos = activities.map{|e| Photo.where({activity_id: e.id}) }

    if user_id == itinerary["user_id"]
      render json: {
        response: "Returning requested itinerary",
        status: 200,
        user_id: user_id,
        itinerary_id: itinerary_id,
        itinerary: itinerary,
        activities: activities,
        photos: photos
      }
    else
      render json: {
        response: "Unauthorized usage. user_id does not match itinerary owner",
        status: 401
      }
    end
  end

  def create
    user_id = current_resource_owner["id"]

    request = params["data"]
    createdItinerary = Itinerary.create({
      user_id: user_id,
      title: request["title"],
      country: request["country"],
      bannerUrl: request["bannerUrl"],
      days: request["days"]
      })
    render json: {
      status: 200,
      response: "create new itinerary",
      current_user: current_resource_owner,
      request: params["data"],
      createdItinerary: createdItinerary
    }
  end

  def update
    user_id = current_resource_owner["id"]
    itinerary_id = params["id"]

    request = params["data"]
    itinerary = Itinerary.find(itinerary_id)

    if user_id == itinerary["user_id"]
      updatedItinerary = itinerary.update({
          title: request["title"],
          country: request["country"],
          bannerUrl: request["bannerUrl"],
          days: request["days"]
        })
      render json: {
        response: "update the itinerary",
        current_user: user_id,
        updatedItinerary: updatedItinerary
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
    itinerary_id = params["id"]

    itinerary = Itinerary.find(itinerary_id)

    if user_id == itinerary["user_id"]
      activities = itinerary.activities

      photos = activities.map{|e| Photo.where({activity_id: e.id}) }
      photos.flatten!

      deletedPhotos = photos.each do |e|
        Photo.delete(e)
      end
      deletedActivities = activities.each do |e|
        Activity.delete(e)
      end
      deletedItinerary = Itinerary.delete(itinerary_id)

      render json: {
        response: "delete the itinerary, all associated activities and photos",
        status: 200,
        itinerary_id: itinerary_id,
        deletedPhotos: deletedPhotos,
        deletedActivities: deletedActivities,
        deletedItinerary: deletedItinerary
      }
    else
      render json: {
        response: "unauthorized request",
        status: 401
      }
    end
  end

end
