class ItineraryController < ApplicationController
before_action -> { doorkeeper_authorize! :api }

  def showAll
    render json: {
      response: "show all itineraries"
    }
  end

  def edit
    render json: {
      response: "show and edit one itinerary"
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
