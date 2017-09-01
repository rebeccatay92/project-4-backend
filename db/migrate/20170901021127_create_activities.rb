class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|

      t.references :itinerary, foreign_key: true

      t.integer :day
      t.string :place
      t.string :latitude
      t.string :longitude
      t.string :blurb
      t.string :content

      t.timestamps
    end
  end
end
