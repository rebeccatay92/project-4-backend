class StaticController < ApplicationController

  def index
    allItineraries = Itinerary.where({published: true})
    render json: {
      response: "this is homepage",
      allItineraries: allItineraries
    }
  end

  def show
    requestedBlogId = params["id"]
    requestedBlog = Itinerary.find(requestedBlogId)
    name = requestedBlog.user["name"]

    activities = requestedBlog.activities
    photos = activities.map{|e| Photo.where({activity_id: e.id}) }

    render json: {
      response: "show one blog by id",
      requestedBlogId: params["id"],
      name: name,
      requestedBlog: requestedBlog,
      activities: activities,
      photos: photos
    }
  end

  def findUser
    user = User.find(params["id"])

    render json: {
      user: user
    }
  end

end
