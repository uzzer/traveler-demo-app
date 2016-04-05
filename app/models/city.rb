class City < ActiveRecord::Base
  has_many :routes, foreign_key: 'source_city_id', class_name: 'Route'
end
