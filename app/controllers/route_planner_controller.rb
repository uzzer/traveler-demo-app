class RoutePlannerController < ApplicationController
  def lookup_form
    @city_name_attributes = City.pluck(:name, :id)
  end

  def lookup
    source = City.find_by_id(params['query']['source'])
    destination = City.find_by_id(params['query']['destination'])

    route =
      Route.find_by(
        source_city: source,
        destination_city: destination
      )

    @response_text = route ? 'Connection found' : 'Connection not found'
    @distance = route.distance if route
  end
end
