class StaticController < ApplicationController

  def home
    render json: {
      response: "this is homepage"
    }
  end

  def show
    render json: {
      response: "show one blog by id"
    }
  end

end
