class CreateItineraries < ActiveRecord::Migration[5.1]
  def change
    create_table :itineraries do |t|
      t.references :user, foreign_key: true
      
      t.string :title
      t.string :country
      t.string :bannerUrl
      t.date :startDate
      t.date :endDate

      t.timestamps
    end
  end
end