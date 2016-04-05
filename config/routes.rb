Rails.application.routes.draw do
  get '/shortest_route_lookup',
      to: 'route_planner#lookup_form',
      as: :shortest_route_lookup
  post '/shortest_route_result',
       to: 'route_planner#lookup',
       as: :shortest_route_result
end
