class StaticController < ApplicationController

  def home
    allItineraries = Itinerary.all
    render json: {
      response: "this is homepage",
      allItineraries: allItineraries
    }
  end

  def show
    requestedBlogId = params["id"]
    requestedBlog = Itinerary.find(requestedBlogId)
    activities = requestedBlog.activities
    photos = activities.map{|e| Photo.where({activity_id: e.id}) }

    render json: {
      response: "show one blog by id",
      requestedBlogId: params["id"],
      requestedBlog: requestedBlog,
      activities: activities,
      photos: photos
    }
  end

end
