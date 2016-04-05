class RoutePlannerController < ApplicationController
  def lookup_form
    @city_name_attributes = City.pluck(:name, :id)
  end

  def lookup
    source = City.find_by_id(params['query']['source'])
    destination = City.find_by_id(params['query']['destination'])

    success, _, distance =
      prepare_graph.shortest_path(source.id, destination.id)

    @response_text = success ? 'Connection found' : 'Connection not found'
    @distance = distance if success
  end

  private

  # TODO: Extract to helper
  def prepare_graph
    self_routes = City.pluck(:id).map { |id| [id, id, 0] }
    db_routes = Route.pluck(
      :source_city_id,
      :destination_city_id,
      :distance
    )
    Graph.new.fill_from_array(db_routes + self_routes)
  end
end
