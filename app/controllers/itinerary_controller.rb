class ItineraryController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def index
    user_id = current_resource_owner["id"]
    allItineraries = Itinerary.where({user_id: user_id})

    render json: {
      response: "show all itineraries by logged in user",
      user_id: user_id,
      allItineraries: allItineraries
    }
  end

  def show
    user_id = current_resource_owner["id"]
    itinerary_id = params["id"]
    # need extra user_id condition in find so ppl cannot access itinerary of other user by modifying url
    itinerary = Itinerary.where({user_id: user_id, id:itinerary_id})

    activities = itinerary[0].activities
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

  def create
    render json: {
      response: "create new itinerary"
    }
  end
  
  def update
    render json: {
      response: "update the itinerary"
    }
  end


end
