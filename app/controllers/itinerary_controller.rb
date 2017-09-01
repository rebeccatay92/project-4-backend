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
    user_id = current_resource_owner["id"]

    request = params["data"]
    createdItinerary = Itinerary.create({
      user_id: user_id,
      title: request["title"],
      country: request["country"],
      startDate: request["startDate"],
      endDate: request["endDate"]
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

    updatedItinerary = itinerary.update({
        title: request["title"],
        country: request["country"],
        startDate: request["startDate"],
        endDate: request["endDate"]
      })

    render json: {
      response: "update the itinerary",
      current_user: user_id,
      itinerary_id: itinerary_id,
      request: request,
      updatedItinerary: updatedItinerary
    }
  end

  #destroy functionality not coded yet 
  def destroy
    user_id = current_resource_owner["id"]
    itinerary_id = params["id"]

    render json: {
      response: "delete the itinerary, associated activities and photos",
      current_user: user_id,
      itinerary_id: itinerary_id,
    }
  end

end
