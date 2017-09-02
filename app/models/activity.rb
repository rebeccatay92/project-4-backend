class Activity < ApplicationRecord
  belongs_to :itinerary
  has_many :photos
end
