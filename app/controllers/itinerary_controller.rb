class ItineraryController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def showAll
    user_id = current_resource_owner["id"]
    allItineraries = Itinerary.where({user_id: user_id})

    render json: {
      response: "show all itineraries by logged in user",
      user_id: user_id,
      allItineraries: allItineraries
    }
  end

  def edit
    user_id = current_resource_owner["id"]
    itinerary_id = params["id"]
    itinerary = Itinerary.find(itinerary_id)
    activities = itinerary.activities
    photos = activities.map{|e| Photo.where({activity_id: e.id}) }

    render json: {
      response: "show one itinerary by logged in user for editing",
      user_id: user_id,
      itinerary_id: itinerary_id,
      itinerary: itinerary,
      activities: activities,
      photos: photos
    }
  end

  def update
    render json: {
      response: "update the itinerary"
    }
  end

  def create
    render json: {
      response: "create new itinerary"
    }
  end

end
