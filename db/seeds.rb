City.destroy_all
Route.destroy_all

[
  ['Amsterdam', 'Hanover', 2],
  ['Amsterdam', 'Brussels', 1],
  ['Amsterdam', 'Munich', 9],
  ['Brussels', 'Paris', 3],
  ['Brussels', 'Luxembourg', 2],
  ['Luxembourg', 'Strasbourg', 5],
  ['Paris', 'Strasbourg', 5],
  ['Strasbourg', 'Zurich', 4],
  ['Strasbourg', 'Munich', 1],
  ['Munich', 'Zurich', 2],
  ['Hanover', 'Nuremberg', 1],
  ['Hanover', 'Berlin', 2],
  ['Berlin', 'Leipzig', 1],
  ['Berlin', 'Prague', 3],
  ['Nuremberg', 'Prague', 2],
  ['Prague', 'Vienna', 3],
  ['Vienna', 'Munich', 3],
  ['Budapest', 'Vienna', 2]
].each do |source_name, destination_name, distance|
  source = City.find_or_create_by(name: source_name)
  destination = City.find_or_create_by(name: destination_name)
  Route.create(
    source_city: source,
    destination_city: destination,
    distance: distance
  )
end
