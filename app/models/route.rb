class Route < ActiveRecord::Base
  belongs_to :source_city,
             class_name: 'City',
             foreign_key: 'source_city_id'
  belongs_to :destination_city,
             class_name: 'City',
             foreign_key: 'destination_city_id'
end
